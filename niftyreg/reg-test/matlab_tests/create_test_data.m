function create_test_data(ref2D_path, ref3D_path, output_path)
%% Add the required files to read and write nifti images
addpath('./NIfTI_20140122');

%% Create the folder to store the result files
if (strcmp(output_path,'.') == 1 || strcmp(output_path,'..') == 1)
    error('[NiftyReg Build Tests] cannot create in . or ..');
end

if ~exist(output_path, 'dir')
    mkdir(output_path);
end
%% Copy the input images into the output folder
if ~exist([output_path, '/refImg2D.nii.gz'], 'file')
    [~,~,ext] = fileparts(ref2D_path); % function 'fileparts'
    if strcmp(ext,'.gz')
        copyfile(ref2D_path, [output_path, '/refImg2D.nii.gz'], 'f');
    else
	% functions 'copyfile' and 'gzip' !!!
        copyfile(ref2D_path, [output_path, '/refImg2D.nii'], 'f');
        gzip([output_path, '/refImg2D.nii'])
    end
    fprintf('[NiftyReg Build Tests] Input 2D file copied\n');
else
    fprintf(['[NiftyReg Build Tests] ', output_path, ...
        '/refImg2D.nii.gz already exists\n'])
end

if ~exist([output_path, '/refImg3D.nii.gz'], 'file')
    [~,~,ext] = fileparts(ref2D_path);
    if strcmp(ext,'.gz')
        copyfile(ref3D_path, [output_path, '/refImg3D.nii.gz'], 'f');
    else
        copyfile(ref3D_path, [output_path, '/refImg3D.nii'], 'f');
        gzip([output_path, '/refImg3D.nii'])
    end
    fprintf('[NiftyReg Build Tests]Input 3D file copied\n');
else
    fprintf(['[NiftyReg Build Tests] ', output_path, ...
		'/refImg3D.nii.gz already exists\n'])
end

ref2D=[output_path, '/refImg2D.nii.gz'];
ref3D=[output_path, '/refImg3D.nii.gz'];



%% Create affine matrix and associated deformation fields
fprintf('[NiftyReg Build Tests] Starting to generate affine deformation fields\n')
if ~exist([output_path,'/affine_mat2D.txt'], 'file') || ...
   ~exist([output_path,'/affine_mat3D.txt'], 'file') || ...
   ~exist([output_path,'/affine_def2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/affine_def2D.nii.gz'], 'file')
   %=======================================================
    affineDeformationField_test(ref2D, ref3D, output_path);
    fprintf('[NiftyReg Build Tests] Affine deformation fields created\n');
else
    fprintf('[NiftyReg Build Tests] Affine deformation fields already exist\n');
end


%% Create control point grids and associated deformation fields
fprintf('[NiftyReg Build Tests] Starting to generate spline deformation fields\n')
if ~exist([output_path,'/bspline_def2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/bspline_def3D.nii.gz'], 'file') || ...
   ~exist([output_path,'/bspline_grid2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/bspline_grid3D.nii.gz'], 'file')
   %=======================================================
    getBSplineField_test(ref2D, ref3D, output_path);
    fprintf('[NiftyReg Build Tests] Spline deformation fields created\n');
else
    fprintf('[NiftyReg Build Tests] Spline deformation fields already exist\n');
end


%% Create data to test the block matching
fprintf('[NiftyReg Build Tests] Starting to generate Block matching test data\n')
if ~exist([output_path,'/expectedBlockMatching_mat2D.txt'], 'file') || ...
   ~exist([output_path,'/expectedBlockMatching_mat3D.txt'], 'file') || ...
   ~exist([output_path,'/warpedBlockMatchingImg2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warpedBlockMatchingImg3D.nii.gz'], 'file')
   %=======================================================
    blockMatching_test(ref2D, ref3D, output_path);
    fprintf('[NiftyReg Build Tests] Block matching test data created\n');
else
    fprintf('[NiftyReg Build Tests] Block matching test data already exist\n');
end


%% Convert input images to different data type
fprintf('[NiftyReg Build Tests] Starting to generate datatype tests\n')
if ~exist([output_path,'/refImg2D_uchar.nii.gz'], 'file') || ...
   ~exist([output_path,'/refImg3D_uchar.nii.gz'], 'file') || ...
   ~exist([output_path,'/refImg2D_float.nii.gz'], 'file') || ...
   ~exist([output_path,'/refImg3D_float.nii.gz'], 'file') || ...
   ~exist([output_path,'/refImg2D_double.nii.gz'], 'file') || ...
   ~exist([output_path,'/refImg3D_double.nii.gz'], 'file')
   %=======================================================
    changeDataType_test(ref2D, ref3D, output_path);
    fprintf('[NiftyReg Build Tests] datatype tests data created\n');
else
    fprintf('[NiftyReg Build Tests] datatype tests data already exist\n');
end


%% Create interpolated images
fprintf('[NiftyReg Build Tests] Starting to generate interpolation tests\n')
if ~exist([output_path,'/warped_nearest2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warped_linear2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warped_cubic2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warped_nearest3D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warped_linear3D.nii.gz'], 'file') || ...
   ~exist([output_path,'/warped_cubic3D.nii.gz'], 'file')
   %=======================================================
    interpolation_test(ref2D, ref3D, ...
        [output_path,'/affine_def2D.nii.gz'], ...
        [output_path,'/affine_def3D.nii.gz'], ...
        output_path);
    fprintf('[NiftyReg Build Tests] interpolation tests data created\n');
else
    fprintf('[NiftyReg Build Tests] interpolation tests data already exist\n');
end


%% Create data to test the SVD function
fprintf('[NiftyReg Build Tests] Starting to generate SVD tests\n')
if ~exist([output_path,'/inputSVDMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedUMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedSMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedVMatrix.txt'], 'file')
   %=======================================================
    svd_test(output_path);
    fprintf('[NiftyReg Build Tests] SVD tests data created\n');
else
    fprintf('[NiftyReg Build Tests] SVD tests data already exist\n');
end


%% Create data to test each matrix operations
fprintf('[NiftyReg Build Tests] Starting to generate matrix operation tests\n')
if ~exist([output_path,'/inputMatrix1.txt'], 'file') || ...
   ~exist([output_path,'/inputMatrix2.txt'], 'file') || ...
   ~exist([output_path,'/expectedMulMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedAddMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedSubMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedExpMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedLogMatrix.txt'], 'file') || ...
   ~exist([output_path,'/expectedInvMatrix.txt'], 'file')
   %=======================================================
    matrix_operation_test(output_path);
    fprintf('[NiftyReg Build Tests] matrix operation tests data created\n');
else
    fprintf('[NiftyReg Build Tests] matrix operation tests data already exist\n');
end


%% Create data to test the LS and LTS functions
fprintf('[NiftyReg Build Tests] Starting to generate LTS tests\n')
if ~exist([output_path,'/P1_2D.txt'], 'file') || ...
   ~exist([output_path,'/P1_3D.txt'], 'file') || ...
   ~exist([output_path,'/expectedRigidLTS_2D_70.txt'], 'file') || ...
   ~exist([output_path,'/expectedRigidLTS_2D_100.txt'], 'file') || ...
   ~exist([output_path,'/expectedRigidLTS_3D_70.txt'], 'file') || ...
   ~exist([output_path,'/expectedRigidLTS_3D_100.txt'], 'file') || ...
   ~exist([output_path,'/expectedAffineLTS_2D_70.txt'], 'file') || ...
   ~exist([output_path,'/expectedAffineLTS_2D_100.txt'], 'file') || ...
   ~exist([output_path,'/expectedAffineLTS_3D_70.txt'], 'file') || ...
   ~exist([output_path,'/expectedAffineLTS_3D_100.txt'], 'file')
   %=======================================================
    LTS_test(output_path);
    fprintf('[NiftyReg Build Tests] LTS tests data created\n');
else
    fprintf('[NiftyReg Build Tests] LTS tests data already exist\n');
end


%% Create data to test MIND
fprintf('[NiftyReg Build Tests] Starting to generate MIND tests\n')
if ~exist([output_path,'/P1_2D.txt'], 'file') || ...
   ~exist([output_path,'/P1_3D.txt'], 'file') || ...
   ~exist([output_path,'/expectedMINDDescriptor2D_1.nii.gz'], 'file') || ...
   ~exist([output_path,'/expectedMINDDescriptor3D_1.nii.gz'], 'file')
   %=======================================================
    mindDescriptor_test(ref2D, ref3D, output_path, false);
    movefile([output_path,'/expectedMINDDescriptor2D.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor2D_1.nii.gz']);
    movefile([output_path,'/expectedMINDDescriptor3D.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor3D_1.nii.gz']);
    fprintf('[NiftyReg Build Tests] MIND 1 tests data created\n');
else
    fprintf('[NiftyReg Build Tests] MIND 1 tests data already exist\n');
end


if ~exist([output_path,'/P1_2D.txt'], 'file') || ...
   ~exist([output_path,'/P1_3D.txt'], 'file') || ...
   ~exist([output_path,'/expectedMINDDescriptor2D_2.nii.gz'], 'file') || ...
   ~exist([output_path,'/expectedMINDDescriptor3D_2.nii.gz'], 'file')
   %=======================================================
    mindDescriptor_test([output_path,'/warped_linear2D.nii.gz'], ...
        [output_path,'/warped_linear3D.nii.gz'], output_path, false);
    movefile([output_path,'/expectedMINDDescriptor2D.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor2D_2.nii.gz']);
    movefile([output_path,'/expectedMINDDescriptor3D.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor3D_2.nii.gz']);
    fprintf('[NiftyReg Build Tests] MIND 2 tests data created\n');
else
    fprintf('[NiftyReg Build Tests] MIND 2 tests data already exist\n');
end


%% Create data to test SSD similarity measure
fprintf('[NiftyReg Build Tests] Starting to generate SSD tests\n')
if ~exist([output_path,'/expectedSSDValue2D.txt'], 'file') || ...
   ~exist([output_path,'/expectedSSDValue3D.txt'], 'file')
   %=======================================================
    SSD_test([output_path,'/expectedMINDDescriptor2D_1.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor2D_2.nii.gz'], output_path);
    SSD_test([output_path,'/expectedMINDDescriptor3D_1.nii.gz'], ...
        [output_path,'/expectedMINDDescriptor3D_2.nii.gz'], output_path);
    fprintf('[NiftyReg Build Tests] SSD tests data created\n');
else
    fprintf('[NiftyReg Build Tests] SSD tests data already exist\n');
end


%% Create data to test MIND similarity measure
fprintf('[NiftyReg Build Tests] Starting to generate MIND SSD tests\n')
if ~exist([output_path,'/expectedMINDSSDValue2D.txt'], 'file') || ...
   ~exist([output_path,'/expectedMINDSSDValue3D.txt'], 'file')
   %=======================================================
    MINDSSD_test(ref2D,[output_path,'/warped_linear2D.nii.gz'], ...
                 ref3D,[output_path,'/warped_linear3D.nii.gz'], ...
                 output_path);
    fprintf('[NiftyReg Build Tests] MIND SSD tests data created\n');
else
    fprintf('[NiftyReg Build Tests] MIND SSD tests data already exist\n');
end


%% Create data to test gradient
fprintf('[NiftyReg Build Tests] Starting to generate gradient tests\n')
if ~exist([output_path,'/expectedImageGradient2D.nii.gz'], 'file') || ...
   ~exist([output_path,'/expectedImageGradient3D.nii.gz'], 'file')
   %=======================================================
    imageGradient_test([output_path,'/expectedMINDDescriptor2D_1.nii.gz'],...
                       [output_path,'/expectedMINDDescriptor3D_1.nii.gz'],...
                        output_path);
    fprintf('[NiftyReg Build Tests] gradient tests data created\n');
else
    fprintf('[NiftyReg Build Tests] gradient tests data already exist\n');
end


%% Create data to test MIND-SSC
fprintf('[NiftyReg Build Tests] Starting to generate MINDSSC tests\n')
if ~exist([output_path,'/P1_2D.txt'], 'file') || ...
   ~exist([output_path,'/P1_3D.txt'], 'file') || ...
   ~exist([output_path,'/expectedMINDSSCDescriptor2D_1.nii.gz'], 'file') || ...
   ~exist([output_path,'/expectedMINDSSCDescriptor3D_1.nii.gz'], 'file')
   %=======================================================
    mindsscDescriptor_test(ref2D, ref3D, output_path, false);
    movefile([output_path,'/expectedMINDSSCDescriptor2D.nii.gz'], ...
        [output_path,'/expectedMINDSSCDescriptor2D_1.nii.gz']);
    movefile([output_path,'/expectedMINDSSCDescriptor3D.nii.gz'], ...
        [output_path,'/expectedMINDSSCDescriptor3D_1.nii.gz']);
    fprintf('[NiftyReg Build Tests] MINDSSC 1 tests data created\n');
else
    fprintf('[NiftyReg Build Tests] MINDSSC 1 tests data already exist\n');
end


if ~exist([output_path,'/P1_2D.txt'], 'file') || ...
   ~exist([output_path,'/P1_3D.txt'], 'file') || ...
   ~exist([output_path,'/expectedMINDSSCDescriptor2D_2.nii.gz'], 'file') || ...
   ~exist([output_path,'/expectedMINDSSCDescriptor3D_2.nii.gz'], 'file')
   %=======================================================
    mindsscDescriptor_test([output_path,'/warped_linear2D.nii.gz'], ...
        [output_path,'/warped_linear3D.nii.gz'], output_path, false);
    movefile([output_path,'/expectedMINDSSCDescriptor2D.nii.gz'], ...
        [output_path,'/expectedMINDSSCDescriptor2D_2.nii.gz']);
    movefile([output_path,'/expectedMINDSSCDescriptor3D.nii.gz'], ...
        [output_path,'/expectedMINDSSCDescriptor3D_2.nii.gz']);
    fprintf('[NiftyReg Build Tests] MINDSSC 2 tests data created\n');
else
    fprintf('[NiftyReg Build Tests] MINDSSC 2 tests data already exist\n');
end


%% Create data to test the convolution
fprintf('[NiftyReg Build Tests] Starting to generate convolution\n')
if ~exist([output_path,'/convolution2D_mea.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution2D_lin.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution2D_gau.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution2D_spl.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution3D_mea.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution3D_lin.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution3D_gau.nii.gz'], 'file') || ...
   ~exist([output_path,'/convolution3D_spl.nii.gz'], 'file')
   %=======================================================
    getConvolution_test(ref2D, ref3D, output_path);
    fprintf('[NiftyReg Build Tests] Convolution tests data created\n');
else
    fprintf('[NiftyReg Build Tests] Convolution tests data already exist\n');
end


%% Create data to test the linear elasticity
fprintf('[NiftyReg Build Tests] Starting to generate linear elasticity data\n')
if  ~exist([output_path,'/le_spline_approx2D.txt'], 'file') || ...
    ~exist([output_path,'/le_spline_dense2D.txt'], 'file') || ...
    ~exist([output_path,'/le_field_dense2D.txt'], 'file') || ...
    ~exist([output_path,'/le_spline_approx3D.txt'], 'file') || ...
    ~exist([output_path,'/le_spline_dense3D.txt'], 'file') || ...
    ~exist([output_path,'/le_field_dense3D.txt'], 'file')
   %=======================================================
    getLinearElasticityValue_test( ...
        [output_path,'/bspline_grid2D.nii.gz'] , ...
        [output_path,'/bspline_def2D.nii.gz'] , ...
        [output_path,'/bspline_grid3D.nii.gz'] , ...
        [output_path,'/bspline_def3D.nii.gz'] , ...
        output_path);
    fprintf('[NiftyReg Build Tests] Linear elasticity data tests data created\n');
else
    fprintf('[NiftyReg Build Tests] Linear elasticity data tests data already exist\n');
end


%% Create data to test the linear elasticity gradient
fprintf('[NiftyReg Build Tests] Starting to generate linear elasticity gradient data\n')
if  ~exist([output_path,'/le_grad_spline_approx2D.nii.gz'], 'file') || ...
    ~exist([output_path,'/le_grad_spline_dense2D.nii.gz'], 'file') || ...
    ~exist([output_path,'/le_grad_field_dense2D.nii.gz'], 'file') || ...
    ~exist([output_path,'/le_grad_spline_approx3D.nii.gz'], 'file') || ...
    ~exist([output_path,'/le_grad_spline_dense3D.nii.gz'], 'file') || ...
    ~exist([output_path,'/le_grad_field_dense3D.nii.gz'], 'file')
   %=======================================================
    getLinearElasticityGradient_test( ...
        [output_path,'/bspline_grid2D.nii.gz'] , ...
        [output_path,'/bspline_def2D.nii.gz'] , ...
        [output_path,'/bspline_grid3D.nii.gz'] , ...
        [output_path,'/bspline_def3D.nii.gz'] , ...
        output_path);
    fprintf('[NiftyReg Build Tests] Linear elasticity gradient data tests data created\n');
else
    fprintf('[NiftyReg Build Tests] Linear elasticity gradient data tests data already exist\n');
end
