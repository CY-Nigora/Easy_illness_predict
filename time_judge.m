function [monat,tag]=time_judge(t)

if t<=11
    tag=21+t;
    monat=1;
else if t<=40
        tag=t-10;
        monat=2;
    else tag=t-40+1;
        monat=3;
    end
end

end