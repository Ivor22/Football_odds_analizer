using CSV
using DataFrames


function analiza()

    koef_input1=1.1
    koef_input2=1.4
    df = CSV.File("hnl-2020-2021.csv") |> DataFrame

    println("START")
#    println("POCETNI IZNOS:",10)

        for koef_input1 in 11:33
            koef_input1=koef_input1/10
            for koef_input2 in 11:33
                koef_input2=koef_input2/10
                if koef_input1>koef_input2
                    cnt1=0
                    cnt2=0
                    cnt_uk=0
                    poc_ul=10
                    lok_ul=2
                    println("ki1:",koef_input1," ki2:",koef_input2)
                    for row in reverse(eachrow(df))
                        cnt_uk+=1
#                        println("******************************")
#                        println("UTAKMICA#:",cnt_uk)
                        #println(row)

                        
                        G1 = row."G1"
                        G2 = row."G2"
                        Tko = row."Tko"
                        koef_1 = row."1"
                        koef_x = row."X"
                        koef_2 = row."2"
                        koef_1x = 1/(1/koef_1+1/koef_x)
                        koef_x2 = 1/(1/koef_2+1/koef_x)
                        koef_1x = round(koef_1x; digits = 2)
                        koef_x2 = round(koef_x2; digits = 2)
#                        println("Tko: ",Tko," G1:",G1," G2:",G2," k1:",koef_1," kx:",koef_x," k2:",koef_2 )

                        #UVJET ZA ENTER TRADE
                        if ((koef_1x<koef_input1) && (koef_1x>koef_input2) && (koef_1x<koef_x2)) || ((koef_x2<koef_input1) && (koef_x2>koef_input2) && (koef_1x>koef_x2))
                            #DOBITAK
            #                if (((G1 > G2) && (koef_1<koef_input)) && (koef_1<koef_2)) || (((G2 > G1) && (koef_2<koef_input)) && (koef_2<koef_1)) || ((G2 == G1) && (min(koef_1,koef_2)<koef_input))
                            if ((G1>G2) && (koef_1x<koef_input1) && (koef_1x>koef_input2) && (koef_1x<koef_x2)) || ((G1<G2) && (koef_x2<koef_input1) && (koef_x2>koef_input2) && (koef_1x>koef_x2)) || (G1==G2)

                                cnt1+=1
                                if (G1>G2)
                                    koef=koef_1x
                                elseif (G2>G1)
                                    koef=koef_x2 
                                elseif (G2==G1)
                                    koef=min(koef_1x,koef_x2)
            #                    koef=1.1
                                end
                                lok_ul=2*(koef-0.06)
                                poc_ul=poc_ul-2+lok_ul
#                                println("koef_input1:",koef_input1," koef_input2:", koef_input2)
#                                println("ULOG:2")
#                                println("DOBITAK:",lok_ul)
#                                println("NA RACUNU:",poc_ul)
#                                println("#dobitaka:",cnt1)
                                #println("G1:",G1,"koef_1:",koef_1,"koef_x:",koef_x,"koef_2:",koef_2 )
                            #GUBITAK
            #                elseif ((G1 < G2) && (koef_1<koef_input)) || ((G2 < G1) && (koef_2<koef_input)) 
                            elseif ((G1<G2) && (koef_1x<koef_x2)) || ((G1>G2) && (koef_1x>koef_x2) )
                                cnt2+=1
                                poc_ul=poc_ul-2
#                                println("ULOG:2")
#                                println("GUBITAK:2")
#                                println("NA RACUNU:",poc_ul)
#                                println("#gubitaka:",cnt2)
                        else
#                            println("NIJE ULOŽENO")
                            end
                        end
                    end
#                println("<<<<<<<<<<<<<<<<<<<<<<<<<")
#                println("UKUPNO UTAKMICA:",cnt_uk)
#                println("UKUPNO ULOZENIH UTAKMICA:",cnt1+cnt2)
#                println("UKUPNO DOBITAKA:",cnt1)
#                println("UKUPNO GUBITAKA:",cnt2)
#                println("POCETNI IZNOS:",10)
                println("KRAJNJI IZNOS:",poc_ul)
#                println("STOP")
                end
            end
        end
end

analiza()