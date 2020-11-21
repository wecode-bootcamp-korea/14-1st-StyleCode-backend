description ="#메인부스 니트입니다. 색깔이 너무 이쁘쥬? #짜임도#진짜 짱짱해서 자주 손이 갑니다~nsta : yoonanhi_#여자코디 #여자데일리룩#al#la#asda#asd #20대코디 #슬렉스 #슬렉스코디 #가을코디 #겨울룩 #데이트룩 #니트추천 #가을코디 #메인부스 #니트"

a=description.split()


for i in a:
    if '#' in i:
        if not ('#' in i[0]):
            b =i.find('#')
            ab = i[b:]
            abc = ab.split('#')
            for m in abc:
                if len(m) != 0:
                    print("#"+m)
        else: 
            k = i.lstrip('#')
            if '#' in k :
                ak = k.split('#')
                for l in ak:
                    print('#'+l)
            else:
                print('#'+k)
            
