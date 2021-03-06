function interpolation_test(img2D_name, img3D_name, def2D_name, def3D_name, output_path)
%%
%% Create a warped image from an affine deformation field according to an interpolation order
%%
inputImg_name= {img2D_name, img3D_name};
inputDef_name= {def2D_name, def3D_name};

for d=2:3
    % Read the input images
    inputImage = load_untouch_nii(inputImg_name{d-1}); % read the Nifti file
    inputData = single(inputImage.img);

    HMatrix = eye(4,4,'single');
    HMatrix(1,:) = inputImage.hdr.hist.srow_x;
    HMatrix(2,:) = inputImage.hdr.hist.srow_y;
    HMatrix(3,:) = inputImage.hdr.hist.srow_z;
    worldToVoxelMatrix = single(inv(double(HMatrix)));

    inputDef = load_untouch_nii(inputDef_name{d-1}); % read the Nifti file
    inputDefData = single(inputDef.img);
    
    for type={'nearest', 'linear', 'cubic'}
        
        expectedWarpedImage = zeros(inputDef.hdr.dime.dim(2),...
            inputDef.hdr.dime.dim(3),inputDef.hdr.dime.dim(4),...
            'single');
        
        if d==2
            [X,Y] = ndgrid((0:size(inputData,1)-1),...
                (0:size(inputData,2)-1));
            X=single(X);
            Y=single(Y);
            Z='';
        elseif d==3
            [X,Y,Z] = ndgrid((0:size(inputData,1)-1),...
                (0:size(inputData,2)-1),...
                (0:size(inputData,3)-1));
            X=single(X);
            Y=single(Y);
            Z=single(Z);
        end
        for kk=1:size(expectedWarpedImage,3)
            for jj=1:size(expectedWarpedImage,2)
                for ii=1:size(expectedWarpedImage,1)
                    if d==2
                        currentWorldPosition = [...
                            inputDefData(ii,jj,kk,1,1) ...
                            inputDefData(ii,jj,kk,1,2) 0 1];
                    elseif d==3
                        currentWorldPosition = [...
                            inputDefData(ii,jj,kk,1,1) ...
                            inputDefData(ii,jj,kk,1,2) ...
                            inputDefData(ii,jj,kk,1,3) ...
                            1];
                    end
                    correspondingVoxelPosition = single(...
                        double(worldToVoxelMatrix) * ...
                        double(currentWorldPosition)');
                    if d==2
                        intensityValue = interpn(...
                            double(X),...
                            double(Y),...
                            double(inputData),...
                            double(correspondingVoxelPosition(1)),...
                            double(correspondingVoxelPosition(2)),...
                            type{1}, -999999);
                    elseif d==3
                        intensityValue = interpn(...
                            double(X),...
                            double(Y),...
                            double(Z),...
                            double(inputData),...
                            double(correspondingVoxelPosition(1)),...
                            double(correspondingVoxelPosition(2)),...
                            double(correspondingVoxelPosition(3)),...
                            type{1}, -999999);
                    end
                    expectedWarpedImage(ii,jj,kk)=single(intensityValue);
                end
            end
        end
        expectedWarpedImage(expectedWarpedImage(:,:,:)==single(-999999)) = NaN;

	% =============== the same data type ===============================
        % The floating and warped image should have the same datatype !
        expectedWarpedImage_nii = make_nii(expectedWarpedImage,...
            [inputDef.hdr.dime.pixdim(2),...
            inputDef.hdr.dime.pixdim(3),...
            inputDef.hdr.dime.pixdim(4)],...
            [],...
            16); % 16 is float

        save_nii(expectedWarpedImage_nii, [output_path,'/warped_', type{1}, num2str(d), 'D.nii.gz']);
    end
end
