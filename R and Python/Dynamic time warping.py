import numpy
def dis_abs(x,y):
    return abs(x-y)[0]

def estimate_twf(A,B,dis_func=dis_abs):

    N_A = len(A)
    N_B = len(B)

    D =numpy.zeros([N_A,N_B])
    D[0,0]=dis_func(A[0],B[0])

    for i in range(1,N_A):
        D[i,0]=D[i-1,0]+dis_func(A[i],B[0])
    for j in range(1,N_B):
        D[0,j]=D[0,j-1]+dis_func(A[0],B[j])
    for i in range(1,N_A):
        for j in range(1,N_B):
            D[i,j]=dis_func(A[i],B[j])+min(D[i-1,j],D[i,j-1],D[i-1,j-1])
            
    i= N_A - 1
    j= N_B - 1
    count =0
    d = numpy.zeros(max(N_A,N_B)*3)
    path=[]
    while True:
        if i>0 and j>0:
            path.append((i,j))
            m=min(D[i-1,j],D[i,j-1],D[i-1,j-1])
            if m == D[i-1,j-1]:
                d[count]=D[i,j]-D[i-1,j-1]
                i=i-1
                j=j-1
                count=count+1

            elif m == D[i,j-1]: 
             d[count]=D[i,j]-D[i,j-1]
             j=j-1
             count=count+1

            elif m ==D[i-1,j]:
             d[count]=D[i,j]-D[i-1,j ]
             i=i-1
             count=count+1

            elif i ==0 and j==0:
              path.append((i,j))
              d[count]=D[i,j]
              count=count+1
              break

            elif i==0:
              path.append((i,j))
              d[count]=D[i,j]-D[i,j-1]
              j=j-1
              count=count+1


            elif j==0:
              path.append((i,j))
              d[count]=D[i,j]-D[i-1,j]
              i=i-1
              count=count+1

        mean =numpy.sum(d)/count
        return mean, path[::-1],D

a=numpy.array([0.03,0.0543,0.1418,0.228,0.3319,0.3368,0.3384,0.3375,0.3279,0.323])
b=numpy.array([0.03,0.0543,0.1418,0.228,0.3319,0.3368,0.3384,0.3375,0.3279,0.323])
a=a[:,numpy.newaxis]
b=b[:,numpy.newaxis]
dis,path,D=estimate_twf(a,b,dis_func=dis_abs)
print(dis)
print(path)
print(D)



