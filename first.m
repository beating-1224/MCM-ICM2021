clear;clc

% ��������
load data.mat     % ��
% ��ʼ��������
sj = [data;test];
for i=1:length(sj)
    for j=1:length(sj)
        if i==j
            all_d(i,j)=0;
        else
            % X���ȣ�Yγ��
            Y1 = sj(i,1);Y2=sj(j,1);
            X1 =sj(i,2);X2=sj(j,2);
            all_d(i,j)=6370*acos(cos(Y1)*cos(Y2)*cos(X1-X2)+sin(Y1)*sin(Y2))*pi/180;
        end
    end
end

for i=1:length(data)
    for j=1:length(data)
        if i==j
            d(i,j)=0;
        else
            % X���ȣ�Yγ��
            Y1 = data(i,1);Y2=data(j,1);
            X1 = data(i,2);X2=data(j,2);
            d(i,j)=6370*acos(cos(Y1)*cos(Y2)*cos(X1-X2)+sin(Y1)*sin(Y2))*pi/180;
        end
    end
end
d;         % ���Կ�������������Ѩ���볬����4���������Դ��������
% 
% ����



X = (data(1,1)+data(2,1)+data(4,1))/3;          % γ��
Y = (data(1,2)+data(2,2)+data(4,2))/3;          % ����
ori = [X,Y;data(3,1),data(3,2)];       % ��Դ��
% �ǵû�����Դ�صĵ�ͼ

xin_space = [];
all_f =0;
while all_f ==0

    for z = 1:2
        X = ori(z,1);Y=ori(z,2);
        f1 = 1;
        while  f1 == 1        % ��֤����������Ǩ�����
            flag = 0;
            % 30/111�Ȳ�����30����
            fen = 2;            % ���Ѵ���
            while flag==0
                new_dian = zeros(fen,2);
                f2 = 0;
                for j=1:fen          % ���ѳ�n���䳲
                    while  f2==0
                        tem_1 = unifrnd(-20/111,20/111);
                        tem_2 = unifrnd(-20/111,20/111);
                        new_X = X+tem_1;
                        new_Y = Y+tem_2;
                        dd = 6370*acos(cos(X)*cos(new_X)*cos(Y-new_Y)+sin(X)*sin(new_X))*pi/180;
            %             disp(dd);
                        if new_Y>-70         % �����ܺ���
                            continue
                        elseif dd>30         % ��֤��30��������
                            continue
                        else
                            new_dian(j,1) = new_X;
                            new_dian(j,2) = new_Y;
                            break;
                        end
                    end
                end
                flag=1;
            end
            f1 = 0;
        end
        xin_space = [xin_space;new_dian];
    end
  
    % ���������·䳲֮��ľ���
    for p=1:length(xin_space)
        for q=1:length(xin_space)
            if p==q
                tem_d(p,q)=0;
            else
                % X���ȣ�Yγ��
                Y1 = xin_space(p,1);Y2=xin_space(q,1);
                X1 =xin_space(p,2);X2=xin_space(q,2);
                tem_d(p,q)=6370*acos(cos(Y1)*cos(Y2)*cos(X1-X2)+sin(Y1)*sin(Y2))*pi/180;
            end
        end
    end
    
    disp(sum(sum(tem_d>4)))
    % ��֤���е��µķ䳲֮��ľ��붼����4
    if  sum(sum(tem_d>4))==0
        all_f = 1;
    else
         all_f = 0;
         xin_space=[];
    end

end

xin_space
% �ж�test�е�����������һ���³�
result =[];


for i=1:length(test)
    pand = [];
    % X���ȣ�Yγ��
    Y1 = test(i,1);X1 = test(i,2);
    for j=1:length(xin_space)
        Y2 = xin_space(j,1);X2 = xin_space(j,2);
        pand(j)=6370*acos(cos(Y1)*cos(Y2)*cos(X1-X2)+sin(Y1)*sin(Y2))*pi/180;
    end
    [tem_min,tem_location] = min(pand);  % ��Сֵ��λ��
    result(i,1) =tem_location ;
    result(i,2) = tem_min ;
end
result



figure(1)
scatter(data(:,2),data(:,1),'.')
hold on
scatter(test(:,2),test(:,1),'.')
hold on
scatter(xin_space(:,2),xin_space(:,1))
legend('Origin','True','New')