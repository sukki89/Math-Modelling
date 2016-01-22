function data = text_file_read(filename)
    idx=0;

    fid = fopen(filename)
    if fid == -1
         error(['Error Opening ',filename]);
    end
    while ~feof(fid)
       data_to_split = fgetl(fid);
       split = strsplit(data_to_split,',');
       [rows,cols] = size(split);
       while(cols ~= 0)
         idx=idx+1;
         data(idx) = split(1,cols);
         cols = cols -1;
       end
    end
    fclose(fid);
end

unique_data = unique(data);
[rows,cols] = size(unique_data);
count_arr(1:10) = 0

for i=1:cols
    clear x;
    x = unique_data(1,i){1};
    ans = strsplit(strtrim(x),' ');
    [rows1,cols1] = size(ans);
    j = 1;
    while(j<= cols1)
         clear ans;
         ans = strsplit(strtrim(x),' ');
         clear ans1;
         ans1 = str2num(ans(1,j){1});
         if(ans1 ~= 0)
             break;
         end
         j++;
    end
    if(j >cols1)
        ans1 = 10;
    end
    count_arr(ans1) += 1;
end
statPercent = count_arr(1:9)/ sum(count_arr (1:9));
bar(statPercent);