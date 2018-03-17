//http://c.biancheng.net/cpp/html/34.html
# include <stdio.h>
# include <stdlib.h>
# include <string.h>
# include <math.h>

int test(int argc, char const *argv[])
{
	printf("Hello, world\n");
	return 0;
}


/*经典算法100例--001*/

int mytest001(int argc, char const *argv[])
{
	int count=0;
	int res=0;
	int i=0, j=0, k=0;

	for (i = 1; i <= 4; ++i){
		for (j = 1; j <= 4; ++j){
			for (k = 1; k <= 4; ++k){
				if (i==j && j==k){
					res++;					
				}
				int tmp = i*100+j*10+k;
				count++;
				printf("%d\n", tmp);
			}
		}
	}
	printf("%d, %d, %d\n", res, count, count-res);
	return 0;
}

int test001(int argc, char const *argv[])
{
	int i,j,k,count=0;
	printf("--------------------------\n");

	for (i = 1; i < 5; ++i){
		for (j = 1; j < 5; ++j){
			for(k=1;k<5;k++){
				if (i!=j && j!=k)
					printf("%d, %d, %d\n", i,j,k);
				count++;
			}
		}
	}
	printf("count = %d\n", count);
	return 0;
}



/*经典算法100例--002*/


int mytest002()
{
	float money, allowance;

	printf("please input money for each month!\n");
	scanf("%f",&money);

	if (money<10. && money>=0.)         allowance = money*0.1;
	else if (money>=10. && money<20.)   allowance = 10.*0.1+ (money-10.)*0.075;
	else if (money>=20. && money<40.)   allowance = 10.*0.1+10.*0.075+(money-20.)*0.05;
	else if (money>=40. && money<60.)   allowance = 10.*0.1+10.*0.075+20.*0.05+(money-40.)*0.03;
	else if (money>=60. && money<100.)  allowance = 10.*0.1+10.*0.075 + 20.*0.05 + 20.*0.03 + (money-60.)*0.015;
	else if (money>=100)                allowance = 10.*0.1 + 10.*0.075 + 20.*0.05 + 20.*0.03 + 40.*0.015 + (money-100.)*0.01;
	else                                printf("please input proper money (>=0) for each month\n");

	printf("%f\n", allowance);
	return 0;
}


int test002(int argc, char const *argv[])
{
	float i;
	float bonus1,bonus2,bonus4,bonus6, bonus10,bonus;

	scanf("%f", &i);

	bonus1=10*0.1;
	bonus2=bonus1+10*0.075;
	bonus4=bonus2+20*0.05;
	bonus6=bonus4+20*0.03;
	bonus10=bonus6+40*0.015;

	if (i<10)       bonus = i*0.1;
	else if (i<=20) bonus = bonus1+(i-10)*0.075;
	else if (i<=40) bonus = bonus2+(i-20)*0.05;
	else if (i<=60) bonus = bonus4+(i-40)*0.03;
	else if (i<=100)bonus = bonus6+(i-60)*0.015;
	else                bonus = bonus10+(i-100)*0.01;

	printf("bonus = %f\n", bonus);
	return 0;
}




int mytest003(int argc, char const *argv[])
{
	long sum, i;
	for (i = 0; i < 1000; ++i)
	{
		for (int j =0; j<1000;j++)
		{
			if( (i*i-100)==(j*j-268) && (i*i>=100) && (j*j>=268) )
				{
					printf("i = %d, j = %d, sum = %d\n", i, j, i*i-100, j*j-268);
				}
		}

	}

	return 0;
}



int test003(int argc, char const *argv[])
{
	long int i,x,y,z;

	for (i=1;i<2000;i++)
	{
		x=sqrt(i+100);
		y=sqrt(i+268);

		if (x*x==i+100 && y*y==i+268)
		{
			printf("\n%ld\n", i);
		}
	}
	return 0;
}




int mytest004()
{
	int day, month, year, count=0;

	printf("please innput 'year, month, day'\n");
	scanf("%d, %d, %d",&year, &month, &day);//2017,2,1

	int jan = 31, mar=31, apr =30, may =31,jun =30, jul=31, aug = 31, sep = 30, oct =31, nov = 30;

	int feb;
	if ((year%4==0 && year%100!=0)||(year%400==0))
		feb =29;
	else 
		feb = 28;
	
	switch(month)
	{	
		case 1:
			count = day;
			break;
		case 2:
			count = jan +day;
			break;
		case 3:
			count = jan+feb +day;
			break;
		case 4:
			count = jan+feb+mar +day; 
			break;
		case 5:
			count = jan+feb+mar+apr +day;
			break;
		case 6:
			count = jan+feb+mar+apr+may +day;
			break;
		case 7:
			count = jan+feb+mar+apr+may+jun +day;
			break;
		case 8:
			count = jan+feb+mar+apr+may+jun+jul +day; 
			break;
		case 9:
			count = jan+feb+mar+apr+may+jun+jul+aug +day;
			break;
		case 10:
			count = jan+feb+mar+apr+may+jun+jul+aug+sep +day;
			break;
		case 11:
			count = jan+feb+mar+apr+may+jun+jul+aug+sep+oct +day;
			break;
		case 12:
			count = jan+feb+mar+apr+may+jun+jul+aug+sep+oct+nov +day; 
	}

	printf("jan = %d, feb = %d, mar = %d\n", jan, feb, mar);
	printf("count = %d\n", count);

	return 0;
}


int test004(int argc, char const *argv[])
{
	int day, month, year, sum, leap;

	printf("\nplease input year, month, day\n");

	//scanf("%d, %d, %d", &year, &month, &day);
    scanf("%d %d %d", &year, &month, &day);     //scanf接受数据的格式有其前面的字符串中的分隔符决定

	switch(month)
	{
		case 1: 
			sum = 0; break;
		case 2:
			sum = 31; break;
		case 3:
			sum = 59; break;
		case 4:
			sum = 90; break;
		case 5:
			sum = 120; break;
		case 6:
			sum = 151; break;
		case 7:
			sum = 181; break;
		case 8:
			sum = 212; break;
		case 9:
			sum = 243; break;
		case 10:
			sum = 273; break;
		case 11:
			sum = 304; break;
		case 12:
			sum = 334; break;
		default:
			printf("data error\n"); break;
	}

	sum = sum +day;

	if (year %400==0 || (year%4==0 && year%100!=0))
		leap = 1;
	else 
		leap =0;

	if (leap ==1 && month>2)
		sum++;

	printf("It is the %dth day.\n", sum);

	return 0;
}



int mytest005()
{
	int x, y, z, min, max;

	scanf("%d,%d,%d",&x,&y,&z);

	min = x<y?x:y;
	min = min<z?min:z;

	max = x>y?x:y;
	max = max>z?max:z;

	printf("%d > %d > %d\n", max, x+y+z-min-max, min);


	return 0;
}



int test005(int argc, char const *argv[])
{
	int x,y,z,t;

	scanf("%d%d%d",&x,&y,&z);

	if(x>y)
	{
		t=x;
		x=y;
		y=t;
	}
	if(x>z)
	{
		t=z;
		z=x;
		x=t;
	}

	if(y>z)
	{
		t=y;
		y=z;
		z=t;		
	}

	printf("small to big: %d %d %d\n", x,y,z);
	return 0;
}





/*test006*/


int mytest006(int argc, char const *argv[])
{
	printf("   ***\n");
	printf(" *    \n");
	printf("*     \n");
	printf("*     \n");
	printf(" *    \n");
	printf("   ***\n");
	return 0;
}


int test006(int argc, char const *argv[])
{
	printf("Hello C-world!\n");
	printf(" ****\n");
	printf(" *\n");
	printf(" *\n");
	printf(" ****\n");
	return 0;
}





int mytest007(int argc, char const *argv[])
{
	int k, tmp;
	printf("please input the number of height.\n");
	scanf("%d", &k);
	
	tmp = 2*k;

    /*正三角*/
	while(k)
	{
		printf("%*s", k, "*");
		for(int j=0;j<tmp-2*k;j++)
		{
			printf("%s", "*");
		}
		printf("\n");
		k--;
	}

    printf("\n=============================\n\n");

    k = (int)tmp/2.;
	int tmp2 =k;
	/*倒三角*/
	while(k)
	{
		printf("%*s", tmp2-k+1, "*");

		for(int j=0;j<2*k-2;j++)
		{
			printf("%s", "*");
		}
		printf("\n");
		k--;
	}



	return 0;
}



int test007(int argc, char const *argv[])
{
	char a =176, b=219;

	printf("%c%c%c%c%c\n", b,a,a,a,b);
	printf("%c%c%c%c%c\n", a,b,a,b,a);
	printf("%c%c%c%c%c\n", a,a,b,a,a);
	printf("%c%c%c%c%c\n", a,b,a,b,a);
	printf("%c%c%c%c%c\n", b,a,a,a,b);


	return 0;
}



int mytest008(int argc, char const *argv[])
{
	int i,j;

	for (i = 1; i < 10; ++i)
	{
		for (j = 1; j <= i; ++j)
		{
			printf("%d * %d = %-4d", i,j,i*j);
		}
		printf("\n");
	}

	printf("\n---------------------\n\n");

	for (i = 1; i < 10; ++i)
	{
		for (j = 1; j <= i; ++j)
		{
			printf("%d * %d = %-4d", j,i,i*j);
		}
		printf("\n");
	}


	return 0;
}


int test008(int argc, char const *argv[])
{
	int i,j,result;

	printf("\n");

	for (i = 1; i < 10; ++i)
	{
		for (j = 1; j <= i; ++j)
		{
			result = i*j;
			printf("%d*%d=%-3d", j,i,result);
		}
		printf("\n");
	}
	return 0;
}


int mytest009(int argc, char const *argv[])
{
	char a='a', b='b';

	int i,j;

	printf("-----------------\n");

	for (i = 0; i < 8; ++i)
	{
		if (i%2==0)
		{
			printf("|a|b|a|b|a|b|a|b|\n");
			printf("-----------------\n");
		}
		else
		{
			printf("|b|a|b|a|b|a|b|a|\n");
			printf("-----------------\n");
		}
	}

	return 0;
}


int test009(int argc, char const *argv[])
{
	int i,j;

	for (i=0;i<8;i++)
	{
		for (j = 0; j < 8; j++)
		{
			if ((i+j)%2==0)
				{printf("%c%c", 219, 219);}
			else
				{printf("  ");}
		}
		printf("\n");
	}
	return 0;
}





int mytest010(int argc, char const *argv[])
{
	int step, tmp;
	scanf("%d\n", &step);

	tmp = step;
	while(step)
	{
		printf("%*s\n", (tmp-step)+1, "_");
		step--;
	}

	return 0;
}


int test010(int argc, char const *argv[])
{
	int i,j;

	printf("\1\1\n");

	for (i = 1; i < 11; ++i)
	{
		for (j = 1; j <= i; ++j)
		{
			printf("%c", 219);
		}
	    printf("\n");
	}
	return 0;
}


/*兔子出生问题*/
int test011(int argc, char const *argv[])
{
	long f1=1, f2=1;

	for (int i = 0; i < 20; ++i)
	{
		printf("%12ld %12ld", f1,f2); // %ld ==> long int
		f1=f1+f2;
		f2=f1+f2;
	}

	return 0;
}





int mytest012(int argc, char const *argv[])
{

	int i, j=1, count=0;

	for (i = 101; i <= 200; ++i)
	{
		int tmp=0;
		for(j=1;j <= i;j++)
		{
			if ((i%j)==0) tmp++;
		}
		if (tmp == 2)
			printf("%d\n",i);
	}


	printf("\n======================\n\n");



	for (i = 101; i <= 200; ++i)
	{
		int tmp=0, j=1;
		while(j<= i)
		{
			if ((i%j)==0) tmp++;
			j++;
		}
		if (tmp == 2)
			{printf("%d\n",i);count++;}
	}

	printf("count = %d\n", count);
	return 0;
}




int test012(int argc, char const *argv[])
{
	int m,i,k,h=0, leap=1;

	printf("\n");

	for (m = 101; m<=200; m++)
	{
		k = sqrt(m+1);

		for (i = 2; i <= k; ++i)
			if (m%i==0)	{leap = 0; break;}
			if(leap)
			{
				printf("%-4d", m);
				h++;
				if (h%10==0)
					printf("\n");
			}
		leap=1;
	}
	printf("\nThe total is %d\n", h);
	return 0;
}




int mytest013(int argc, char const *argv[])
{
	int num=1000, i,j,k;

	for (int t = 100; t < num; ++t)
	{
		i = t % 10;
		j = t / 100;
		k = t/10-j*10;

		if (t == i*i*i+j*j*j+k*k*k)
			printf("%d\n", t);
	}

	return 0;
}




int test013(int argc, char const *argv[])
{
	int i,j,k,n;

	printf("water flower's number is:\n");

	for (n = 100; n < 1000; n++)
	{
		i = n/100;
		j = n/10%10;
		k = n%10;

		if (i*100+j*10+k == i*i*i+j*j*j+k*k*k)
			printf("%-5d", n);
	}
	printf("\n");
	return 0;
}




/*将一个正整数分解质因数，例如：90=2*3*3*5*/


int mytest014()
{
	int num, i=2, j=0, count=0;
	scanf("%d", &num);

	int Num = num;
	int tmp[num]={0};

	while (i <= num)
	{
		if (num%i==0)
		{
			tmp[count]=i;
			num = num/i;
			count++;
		}
		else
			i++;
	}


	printf("%d = ", Num);
	for (j = 0; j < count; ++j)
	{
		if (j!=count-1)
			printf("%d*", tmp[j]);
		else
			printf("%d\n", tmp[j]);	
	}
	
	return 0;
}



int test0014(int argc, char const *argv[])
{
	int n, i;

	printf("\nplease input a number: \n");
	scanf("%d",&n);

	printf("%d = ", n);
	for (i = 2; i <= n; ++i)
	{
		while (n!=i)
		{
			if (n%i==0)
			{
				printf("%d*", i);
				n=n/i;
			}
			else
				break;
		}			
	}

	printf("%d\n", n);

	return 0;
}


/*test15---------条件运算符*/

int mytest015(int argc, char const *argv[])
{
	float score;
	printf("please input a score (0,100)\n");
	scanf("%f", &score);

	if (score >=90&&score<=100)
		printf("A\n");
	else if (score<90 && score>=60)
		printf("B\n");
	else if (score>=0&&score<60)
		printf("C\n");
	else 
		printf("please input a score again!\n");

	score>90?printf("A\n"):(score>60?printf("B\n"):printf("C\n"));

	return 0;
}

