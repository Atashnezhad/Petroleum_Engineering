Db <- 8.5 #bit diameter
Re <- Db/((2^0.5)*2) # effective radius
Ce <- 1 # cutter front area efficiency
# WOB <- 25000 # weight on bit klbf
# RPM <- 100 #
# CCS <- 41000 # in psi
NOC <- 32 # number of cutters
Dc <- 0.5 # cutter diameter in inch
Rc <- Dc/2 #cutter radius in inch
BR <- 20 # Back Rake in angle
SR <- 0 # Side Rake in angle
wSTUD <- 0 # weight 1 STUD
wPDC <- 1 # weight 2 PDC
Emb_Length <- 0.2 # Cutter embedded length  
Lcutter <- 2 # cutter length in inch
CutterT <- 0.0276 # cutter thickness in inch
ROPcoff <- 300 # ROP coefficient  
BGThershold <- 8*(Lcutter-Emb_Length)*tan(BR*pi/180)/Dc

#---------------------------------------------
# Cutter Wear Flat Area Temprature parameters
# Tf <- 50 # fluid temprature in C
# kf <- 0.04 # cutter/rock friction coefficient
f <- 0.5 # thermal response function 
# alpha_f <- 1 # 
#---------------------------------------------
DataTimeInter <- 1 # sec
#-----------------------------BG Column

# BG <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/BG.csv", header = T)
BG <- read.csv("../Drilling Simulator/Data_set/BG.csv", header = T)
BG <- 0.01*BG
Num_of_Data <- nrow(BG)
# BU_BG <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/BU_BG.csv", header = T)
BU_BG <- read.csv("../Drilling Simulator/Data_set/BU_BG.csv", header = T)
BU_BG <- 0.01*BU_BG
Num_of_Data <- nrow(BU_BG)

EXPR_new <- 0.15 #Back up cutter exposed when both cutters are new
EXPR_realtime <- matrix(0,Num_of_Data,1)
colnames(EXPR_realtime) <- "inch"


#-----ROP (ft/hr)-----------------------------
ROP <- matrix(0,Num_of_Data,1)
ROP <- data.frame(ROP)
colnames(ROP) <- 'ROP (ft/hr)'
#----------------------------WOB Column
# WOB <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/WOB.csv", header = T)
WOB <- read.csv("../Drilling Simulator/Data_set/WOB.csv", header = T)
WOC <- WOB/NOC
colnames(WOC) <- 'WOC,lbf'
#----------------------------RPM Column
# RPM <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/RPM.csv", header = T)
RPM <- read.csv("../Drilling Simulator/Data_set/RPM.csv", header = T)
#----------------------------CCS Column
# CCS <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/CCS.csv", header = T)
CCS <- read.csv("../Drilling Simulator/Data_set/CCS.csv", header = T)
#----------------------------Tf Column
# Tf <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/Tf.csv", header = T)
Tf <- read.csv("../Drilling Simulator/Data_set/Tf.csv", header = T)
#----------------------------kf Column
# kf <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/kf.csv", header = T)
kf <- read.csv("../Drilling Simulator/Data_set/Kf.csv", header = T)
#----------------------------alpha_f Column
# alpha_f <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/alpha_f.csv", header = T)
alpha_f <- read.csv("../Drilling Simulator/Data_set/alpha_f.csv", header = T)
#----------------------------thermal response function 
# f <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/f.csv", header = T)
f <- read.csv("../Drilling Simulator/Data_set/f.csv", header = T)
#----------------------------khf (w/cm/C) 
# khf <- read.csv("C:/Users/DASLAB Hareland 3/Desktop/R calc file/ROP drafts/khf.csv", header = T)
khf <- read.csv("../Drilling Simulator/Data_set/Khf.csv", header = T)
#----------------------------FN1 and FN2 
#normal forces on cutter and back up cutter
FN1 <- matrix(0,Num_of_Data,1)
colnames(FN1) <- "Lbf"
FN2 <- matrix(0,Num_of_Data,1)
colnames(FN2) <- "Lbf"
#=============Tw and BU_Tw
Tw <- matrix(0,Num_of_Data,1)
colnames(Tw) <- "c"
BU_Tw <- matrix(0,Num_of_Data,1)
colnames(BU_Tw) <- "c"

#-----Cutters work (base and backup)--
work1 <- matrix(0,Num_of_Data,1)
colnames(work1) <- "ft.Lbf"
work2 <- matrix(0,Num_of_Data,1)
colnames(work2) <- "ft.Lbf"
workT <- matrix(0,Num_of_Data,1)
colnames(workT) <- "ft.Lbf"
BU_work1 <- matrix(0,Num_of_Data,1)
colnames(BU_work1) <- "ft.Lbf"
BU_work2 <- matrix(0,Num_of_Data,1)
colnames(BU_work2) <- "ft.Lbf"
BU_workT <- matrix(0,Num_of_Data,1)
colnames(BU_workT) <- "ft.Lbf"

#average wear coff of PDC and STUD 1 and 2
#1
alphaAve <- matrix(0,Num_of_Data,1)
colnames(alphaAve) <- "(ft.Lbf)/inch3"
#2
BU_alphaAve <- matrix(0,Num_of_Data,1)
colnames(BU_alphaAve) <- "(ft.Lbf)/inch3"

#1
cutter_worn_vol_each_datapoint <- matrix(0,Num_of_Data,1)
colnames(cutter_worn_vol_each_datapoint) <- "inch3"
#2
BU_cutter_worn_vol_each_datapoint <- matrix(0,Num_of_Data,1)
colnames(BU_cutter_worn_vol_each_datapoint) <- "inch3"

#1
comulative_cutter_worn_vol <- matrix(0,Num_of_Data,1)
colnames(comulative_cutter_worn_vol) <- "inch3"
#2
BU_comulative_cutter_worn_vol <- matrix(0,Num_of_Data,1)
colnames(BU_comulative_cutter_worn_vol) <- "inch3"

wear_cof_PDC <- 350000000 # (ft.Lbf)/inch3 of pure PDC material
wear_cof_STUD <- 20000 # (ft.Lbf)/inch3 of pure STUD material

#----------------------------Cutter Velocity (m/s) Column
Cutter_Velocity <- 2*pi*RPM*Re*0.0254/60
colnames(Cutter_Velocity) <- 'Cutter_Velocity,m/s'
#----------------------------cutter wear flat length,L (cm) Column
cutter_wearflat_length <- (BG*Dc/8)/sin(pi*BR/180)*2.54
colnames(cutter_wearflat_length) <- 'cutter_wearflat_length,cm'
BU_cutter_wearflat_length <- (BU_BG*Dc/8)/sin(pi*BR/180)*2.54
colnames(BU_cutter_wearflat_length) <- 'BU_cutter_wearflat_length,cm'

NeedToCovered <- (WOB/NOC)/(CCS)
colnames(NeedToCovered) <- 'NeedToCovered'
Max_DOC_OnCutterFace <- (Dc)*cos(BR*pi/180) 
Max_DOC <- Max_DOC_OnCutterFace*cos(BR*pi/180)

#-------------------------------------------------------------------------
BGDc8 <- BG*Dc/8
colnames(BGDc8) <- 'BGDc8'
BGDc8Cos <- BGDc8*cos(BR*pi/180)
colnames(BGDc8Cos) <- 'BGDc8Cos'

BU_BGDc8 <- BU_BG*Dc/8
colnames(BU_BGDc8) <- 'BU_BGDc8'
BU_BGDc8Cos <- BU_BGDc8*cos(BR*pi/180)
colnames(BU_BGDc8Cos) <- 'BU_BGDc8Cos'

#difference between weighted area beneath the cutter and needed area to be covered
Diff_AwW_T_NeedToCovered <- 0 -NeedToCovered
colnames(Diff_AwW_T_NeedToCovered) <- 'Diff_AwW_T_NeedToCovered'

#-------------------------------------------------------------------------
#finding the depth of cut and BG/BU_BG
DOC_accuracy <- 0.0001 # accuracy for finding depth of cut
StepSize <- 0.001

wornVol_accuracy <- 0.0001 #cutter worn volume acuracy
addBG <- 0.01
#===================Cutter #1==================
#==============================================
DOC_real <- matrix(0,nrow=Num_of_Data,ncol=1)
AH_Matrix <- matrix(0,nrow=Num_of_Data,ncol=1)
AV_Matrix <- matrix(0,nrow=Num_of_Data,ncol=1)
DepthOfCut_P <- matrix(0,nrow=Num_of_Data,ncol=1)
DOC_OCF <- matrix(0,nrow=Num_of_Data,ncol=1)
AOCFClean <- matrix(0,nrow=Num_of_Data,ncol=1)
AWOBG <- matrix(0,nrow=Num_of_Data,ncol=1)
ACT <- matrix(0,nrow=Num_of_Data,ncol=1)
AH <- matrix(0,nrow=Num_of_Data,ncol=1)
AV <- matrix(0,nrow=Num_of_Data,ncol=1)
AwTotal <- matrix(0,nrow=Num_of_Data,ncol=1)
AwPDC <- matrix(0,nrow=Num_of_Data,ncol=1)
AwSTUD <- matrix(0,nrow=Num_of_Data,ncol=1)

#==============================================
#==============================================
#===================Cutter #2==================
#==============================================
BU_DOC_real <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AH_Matrix <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AV_Matrix <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_DepthOfCut_P <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_DOC_OCF <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AOCFClean <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AWOBG <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_ACT <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AH <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AV <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AwTotal <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AwPDC <- matrix(0,nrow=Num_of_Data,ncol=1)
BU_AwSTUD <- matrix(0,nrow=Num_of_Data,ncol=1)
#==============================================
#==============================================

#1
cwv <- 0 # cutter worn volume counter "comulative"
#2
BU_cwv <- 0 # cutter worn volume counter "comulative" for back up cutter





























for (i in 1:Num_of_Data){
  
  
  # sprintf("i number is = %i", i) 
  
  DepthOfCut_P[i,1] <- BGDc8Cos[i,1]
  colnames(DepthOfCut_P) <- 'DepthOfCut_P'
  BU_DepthOfCut_P[i,1] <- BU_BGDc8Cos[i,1]
  colnames(BU_DepthOfCut_P) <- 'BU_DepthOfCut_P'
  j <- 0
  
  while(DepthOfCut_P[i,1] < Max_DOC && Diff_AwW_T_NeedToCovered[i,1] < DOC_accuracy){
    
    j <- j+1
    
    
    DepthOfCut_P[i,1] <- DepthOfCut_P[i,1] + StepSize
    
    cat("i=",i,"and J=",j, "\n")
    
    #=======================Cutter #1=========================
    #=========================================================
    #=========================================================
    #=========================================================
    #=========================================================
    
    DOC_OCF[i,1] <- DepthOfCut_P[i,1]/(cos(BR*pi/180));# print(DOC_OCF[1,1])
    colnames(DOC_OCF) <- 'DOC_OCF'
    # AreaOnCutterFaceClean = AOCFC
    AOCFClean[i,1] <- (Rc^2)*acos((Rc-DOC_OCF[i,1])/Rc)-(Rc-DOC_OCF[i,1])*(2*Rc*DOC_OCF[i,1]-(DOC_OCF[i,1])^2)^0.5;# print(AOCFClean[1,1])
    colnames(AOCFClean) <- 'AOCFClean'
    # AreaWornOutBG = AWOBG # worn out area on cutter face
    AWOBG[i,1] <- (Rc^2)*acos((Rc-BGDc8[i,1])/Rc)-(Rc-BGDc8[i,1])*(2*Rc*BGDc8[i,1]-(BGDc8[i,1])^2)^0.5; #print(AWOBG[1,1])
    colnames(AWOBG) <- 'AWOBG'
    #Area Cut Total = ACT # total aera on cutter face
    ACT[i,1] <- AOCFClean[i,1] -AWOBG[i,1]
    colnames(ACT) <- 'ACT'
    # area beneath the cutter
    AH[i,1] <- ACT[i,1]*sin(BR*pi/180)
    colnames(AH) <- 'AH'
    # area infront of cutter
    AV[i,1] <- ACT[i,1]*cos(BR*pi/180)*cos(SR*pi/180)
    colnames(AV) <- 'AV'
    
    #-----------------------------------------
    #calc for Aw total
    Aw1 <- (BG[i,1]*Dc/8)*cos(BR*pi/180)
    Aw2 <- (Aw1-Lcutter*cos((90-BR)*pi/180))/sin((90-BR)*pi/180)
    if (Aw2<0){Aw3 <- 0} else {Aw3 <- Aw2}
    Aw4 <- Aw1/sin((90-BR)*pi/180)
    if (Aw4<Dc){Aw5 <- Aw4} else {Aw5 <- Dc}
    Aw6 <- (Aw5-Rc)/Rc
    Aw7 <- (Aw3-Rc)/Rc
    Aw8 <- (Aw5-Rc)
    Aw9 <- (Aw3-Rc)
    Aw10 <- ((2*Rc*Aw5-Aw5^2)^0.5)/(Rc)^2
    Aw11 <- ((2*Rc*Aw3-Aw3^2)^0.5)/(Rc)^2
    Aw12 <- (Rc^2/2)*(asin(Aw6)+Aw8*Aw10)
    Aw13 <- (Rc^2/2)*(asin(Aw7)+Aw9*Aw11)
    Aw14 <- (Aw12-Aw13)*(2/cos((90-BR)*pi/180))
    AwTotal[i,1] <- Aw14
    
    AwPDC1 <- (BG[i,1]*Dc/8)*cos(BR*pi/180)
    AwPDC2 <- (Aw1-CutterT*cos((90-BR)*pi/180))/sin((90-BR)*pi/180)
    if (AwPDC2<0){AwPDC3 <- 0} else {AwPDC3 <- AwPDC2}
    AwPDC4 <- AwPDC1/sin((90-BR)*pi/180)
    if (AwPDC4<Dc){AwPDC5 <- AwPDC4} else {AwPDC5 <- Dc}
    AwPDC6 <- (AwPDC5-Rc)/Rc
    AwPDC7 <- (AwPDC3-Rc)/Rc
    AwPDC8 <- (AwPDC5-Rc)
    AwPDC9 <- (AwPDC3-Rc)
    AwPDC10 <- ((2*Rc*AwPDC5-AwPDC5^2)^0.5)/(Rc)^2
    AwPDC11 <- ((2*Rc*AwPDC3-AwPDC3^2)^0.5)/(Rc)^2
    AwPDC12 <- (Rc^2/2)*(asin(AwPDC6)+AwPDC8*AwPDC10)
    AwPDC13 <- (Rc^2/2)*(asin(AwPDC7)+AwPDC9*AwPDC11)
    AwPDC14 <- (AwPDC12-AwPDC13)*(2/cos((90-BR)*pi/180))
    AwPDC[i,1] <- AwPDC14
    
    AwSTUD[i,1] <- AwTotal[i,1]-AwPDC[i,1]
    AwW <- wSTUD*AwSTUD[i,1] + wPDC*AwPDC[i,1] + AH[i,1]
    #=========================================================
    #=========================================================
    #=========================================================
    #=========================================================
    #=======================Cutter #2=========================
    
    EXPR_realtime[i,1] <- EXPR_new - BGDc8Cos[i,1] + BU_BGDc8Cos[i,1]
    
    if (DepthOfCut_P[i,1] > EXPR_new+BU_BGDc8Cos[i,1]){
      
      BU_DepthOfCut_P[i,1] <- DepthOfCut_P[i,1] - EXPR_new
      
      BU_DOC_OCF[i,1] <- BU_DepthOfCut_P[i,1]/(cos(BR*pi/180))
      colnames(BU_DOC_OCF) <- 'BU_DOC_OCF'
      # AreaOnCutterFaceClean = AOCFC
      BU_AOCFClean[i,1] <- (Rc^2)*acos((Rc-BU_DOC_OCF[i,1])/Rc)-(Rc-BU_DOC_OCF[i,1])*(2*Rc*BU_DOC_OCF[i,1]-(BU_DOC_OCF[i,1])^2)^0.5
      colnames(BU_AOCFClean) <- 'BU_AOCFClean'
      # AreaWornOutBG = AWOBG # worn out area on cutter face
      BU_AWOBG[i,1] <- (Rc^2)*acos((Rc-BU_BGDc8[i,1])/Rc)-(Rc-BU_BGDc8[i,1])*(2*Rc*BU_BGDc8[i,1]-(BU_BGDc8[i,1])^2)^0.5
      colnames(BU_AWOBG) <- 'BU_AWOBG'
      #Area Cut Total = ACT # total aera on cutter face
      BU_ACT[i,1] <- BU_AOCFClean[i,1] -BU_AWOBG[i,1]
      colnames(BU_ACT) <- 'BU_ACT'
      # area beneath the cutter
      BU_AH[i,1] <- BU_ACT[i,1]*sin(BR*pi/180)
      colnames(BU_AH) <- 'BU_AH'
      # area infront of cutter
      BU_AV[i,1] <- BU_ACT[i,1]*cos(BR*pi/180)*cos(SR*pi/180)
      colnames(BU_AV) <- 'BU_AV'
      
      #-----------------------------------------
      #calc for Aw total
      BU_Aw1 <- (BU_BG[i,1]*Dc/8)*cos(BR*pi/180)
      BU_Aw2 <- (BU_Aw1-Lcutter*cos((90-BR)*pi/180))/sin((90-BR)*pi/180)
      if (BU_Aw2<0){BU_Aw3 <- 0} else {BU_Aw3 <- BU_Aw2}
      BU_Aw4 <- BU_Aw1/sin((90-BR)*pi/180)
      if (BU_Aw4<Dc){BU_Aw5 <- BU_Aw4} else {BU_Aw5 <- Dc}
      BU_Aw6 <- (BU_Aw5-Rc)/Rc
      BU_Aw7 <- (BU_Aw3-Rc)/Rc
      BU_Aw8 <- (BU_Aw5-Rc)
      BU_Aw9 <- (BU_Aw3-Rc)
      BU_Aw10 <- ((2*Rc*BU_Aw5-BU_Aw5^2)^0.5)/(Rc)^2
      BU_Aw11 <- ((2*Rc*BU_Aw3-BU_Aw3^2)^0.5)/(Rc)^2
      BU_Aw12 <- (Rc^2/2)*(asin(BU_Aw6)+BU_Aw8*BU_Aw10)
      BU_Aw13 <- (Rc^2/2)*(asin(BU_Aw7)+BU_Aw9*BU_Aw11)
      BU_Aw14 <- (BU_Aw12-BU_Aw13)*(2/cos((90-BR)*pi/180))
      BU_AwTotal[i,1] <- BU_Aw14
      
      BU_AwPDC1 <- (BU_BG[i,1]*Dc/8)*cos(BR*pi/180)
      BU_AwPDC2 <- (BU_Aw1-CutterT*cos((90-BR)*pi/180))/sin((90-BR)*pi/180)
      if (BU_AwPDC2<0){BU_AwPDC3 <- 0} else {BU_AwPDC3 <- BU_AwPDC2}
      BU_AwPDC4 <- BU_AwPDC1/sin((90-BR)*pi/180)
      if (BU_AwPDC4<Dc){BU_AwPDC5 <- BU_AwPDC4} else {BU_AwPDC5 <- Dc}
      BU_AwPDC6 <- (BU_AwPDC5-Rc)/Rc
      BU_AwPDC7 <- (BU_AwPDC3-Rc)/Rc
      BU_AwPDC8 <- (BU_AwPDC5-Rc)
      BU_AwPDC9 <- (BU_AwPDC3-Rc)
      BU_AwPDC10 <- ((2*Rc*BU_AwPDC5-BU_AwPDC5^2)^0.5)/(Rc)^2
      BU_AwPDC11 <- ((2*Rc*BU_AwPDC3-BU_AwPDC3^2)^0.5)/(Rc)^2
      BU_AwPDC12 <- (Rc^2/2)*(asin(BU_AwPDC6)+BU_AwPDC8*BU_AwPDC10)
      BU_AwPDC13 <- (Rc^2/2)*(asin(BU_AwPDC7)+BU_AwPDC9*BU_AwPDC11)
      BU_AwPDC14 <- (BU_AwPDC12-BU_AwPDC13)*(2/cos((90-BR)*pi/180))
      BU_AwPDC[i,1] <- BU_AwPDC14
      
      BU_AwSTUD[i,1] <- BU_AwTotal[i,1]-BU_AwPDC[i,1]
      BU_AwW <- wSTUD*BU_AwSTUD[i,1] + wPDC*BU_AwPDC[i,1] + BU_AH[i,1]
      
      
    } 
    else{
      
      BU_AwW <- 0
      
    }
    
    #=========================================================
    #=========================================================
    #=========================================================
    #=========================================================
    #=========================================================
    
    
    AwW_T=AwW+BU_AwW #total weighted area beneath the cutter
    Diff_AwW_T_NeedToCovered[i,1] <- AwW_T -NeedToCovered[i,1]
    # DepthOfCut_P[i,1] <- DepthOfCut_P[i,1] + StepSize
    #-------------------------------------------------------------------------
    
  }
  
  
  
  
  
  
  DOC_real[i,1] <- DepthOfCut_P[i,1]- BGDc8Cos[i,1]
  colnames(DOC_real) <- 'DOC_real'
  AH_Matrix[i,1] <- AH[i,1]
  colnames(AH) <- 'AH'
  AV_Matrix[i,1] <- AV[i,1]
  colnames(AV) <- 'AV'
  FN1[i,1] <- AwW/AwW_T
  
  if (DepthOfCut_P[i,1] > EXPR_new+BU_BGDc8Cos[i,1]){
    
    BU_DOC_real[i,1] <- BU_DepthOfCut_P[i,1]- BU_BGDc8Cos[i,1]
    colnames(BU_DOC_real) <- 'BU_DOC_real'
    BU_AH_Matrix[i,1] <- BU_AH[i,1]
    colnames(BU_AH) <- 'BU_AH'
    BU_AV_Matrix[i,1] <- BU_AV[i,1]
    colnames(BU_AV) <- 'BU_AV'
    FN2[i,1] <- BU_AwW/AwW_T
    
  }
  else{
    
    BU_DOC_real[i,1] <- 0
    colnames(BU_DOC_real) <- 'BU_DOC_real'
    BU_AH_Matrix[i,1] <- 0
    colnames(BU_AH) <- 'BU_AH'
    BU_AV_Matrix[i,1] <- 0
    colnames(BU_AV) <- 'BU_AV'
    FN2[i,1] <- 0
    
  }
  
  
  
  ROP[i,1] <- ROPcoff*(5*RPM[i,1]*Re*Ce*((AV_Matrix[i,1]+BU_AV_Matrix[i,1])/2)/(pi*Db*Db/4))
  
  
  
  
  
  
  
  #============================================WEAR AND TEMPRATURE================================================
  #============================================WEAR AND TEMPRATURE================================================
  #============================================WEAR AND TEMPRATURE================================================
  #============================================WEAR AND TEMPRATURE================================================
  #============================================WEAR AND TEMPRATURE================================================
  #============================================WEAR AND TEMPRATURE================================================
  
  if (EXPR_realtime[i,1] > 0){
    # calculations for cutter 1 and 2 for temprature and wear when the EXPR is not zero. Cutters are not in the same level.
    
    
    
    
    # for cutter 1
    ##############
    ##############
    ##############
    ##############
    cutter_wearflat_length[i,1] <- (BG[i,1]*Dc/8)/sin(pi*BR/180)*2.54
    colnames(cutter_wearflat_length) <- 'cutter_wearflat_length,cm'
    
    Tw[i,1] <- Tf[i,1]+((kf[i,1]*(FN1[i,1]*WOC[i,1])*Cutter_Velocity[i,1]*f[i,1])/(AwTotal[i,1]*6.4516))*
      ((1+(3*(pi^0.5)/4)*f[i,1]*khf[i,1]*(Cutter_Velocity[i,1]/(cutter_wearflat_length[i,1]*alpha_f[i,1]))^0.5)^-1)
    
    #============================================================wear function
    work1[i,1] <- (0.083*kf[i,1]*(FN1[i,1]*WOC[i,1])*RPM[i,1]*(2*pi*Re))*(DataTimeInter/60)
    work2[i,1] <- (0.083*Ce*AV_Matrix[i,1]*(2*pi*Re)*RPM[i,1]*CCS[i,1])*(DataTimeInter/60)
    workT[i,1] <- work1[i,1] + work2[i,1]
    alphaAve[i,1] <- (AwPDC[i,1]/AwTotal[i,1])*wear_cof_PDC+(AwSTUD[i,1]/AwTotal[i,1])*wear_cof_STUD
    cutter_worn_vol_each_datapoint[i,1] <- workT[i,1]/alphaAve[i,1]
    
    cwv <- cutter_worn_vol_each_datapoint[i,1]+ cwv
    comulative_cutter_worn_vol[i,1] <- cwv
    
    #calculate the BG by reverse cutter volume equation
    
    V_total_worn_theory <- 0
    
    while(V_total_worn_theory - comulative_cutter_worn_vol[i,1] < wornVol_accuracy){
      
      
      if (i==1){
        BG[i,1] <- BG[i,1] + addBG 
        
        
        V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                       ((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))-
                                          ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                       ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
        
        cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
            "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        
      } 
      else{
        BG[i,1] <- BG[i-1,1] + addBG
        
        # cat("BG=",BG[i,1])
        
        V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                       ((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))-
                                          ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                       ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
        
        cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
            "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        
      }
    }
    #update BG that is used for next ROP calculations
    BG[i+1,1] <- BG[i,1]
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    #for cutter 2 or back up cutter ==== if it is engaged with formation or NOT
    ##############
    ##############
    ##############
    ##############
    
    if (DepthOfCut_P[i,1] > EXPR_new+BU_BGDc8Cos[i,1]){
      
      BU_cutter_wearflat_length[i,1] <- (BU_BG[i,1]*Dc/8)/sin(pi*BR/180)*2.54
      colnames(BU_cutter_wearflat_length) <- 'BU_cutter_wearflat_length,cm'
      
      BU_Tw[i,1] <- Tf[i,1]+((kf[i,1]*(FN2[i,1]*WOC[i,1])*Cutter_Velocity[i,1]*f[i,1])/(BU_AwTotal[i,1]*6.4516))*
        ((1+(3*(pi^0.5)/4)*f[i,1]*khf[i,1]*(Cutter_Velocity[i,1]/(BU_cutter_wearflat_length[i,1]*alpha_f[i,1]))^0.5)^-1)
      
      #============================================================wear function
      BU_work1[i,1] <- (0.083*kf[i,1]*(FN2[i,1]*WOC[i,1])*RPM[i,1]*(2*pi*Re))*(DataTimeInter/60)
      BU_work2[i,1] <- (0.083*Ce*BU_AV_Matrix[i,1]*(2*pi*Re)*RPM[i,1]*CCS[i,1])*(DataTimeInter/60)
      BU_workT[i,1] <- BU_work1[i,1] + BU_work2[i,1]
      BU_alphaAve[i,1] <- (BU_AwPDC[i,1]/BU_AwTotal[i,1])*wear_cof_PDC+(BU_AwSTUD[i,1]/BU_AwTotal[i,1])*wear_cof_STUD
      BU_cutter_worn_vol_each_datapoint[i,1] <- BU_workT[i,1]/BU_alphaAve[i,1]
      
      BU_cwv <- BU_cutter_worn_vol_each_datapoint[i,1]+ BU_cwv
      BU_comulative_cutter_worn_vol[i,1] <- BU_cwv
      
      #calculate the BU_BG by reverse cutter volume equation
      # wornVol_accuracy <- 0.001
      BU_V_total_worn_theory <- 0
      
      while(BU_V_total_worn_theory - BU_comulative_cutter_worn_vol[i,1] < wornVol_accuracy){
        
        if (i==1){
          BU_BG[i,1] <- BU_BG[i,1] + addBG
          
          BU_V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                            ((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))-
                                               ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                            ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
          
          cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
              "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        } 
        else{
          BU_BG[i,1] <- BU_BG[i-1,1] + addBG 
          
          BU_V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                            ((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))-
                                               ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                            ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
          
          cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
              "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        }
      }
      #update BG that is used for next ROP calculations
      BU_BG[i+1,1] <- BU_BG[i,1]
      
      
    }
    else{
      
      BU_BG[i+1,1] <- BU_BG[i,1]
      
    }
    
    
    
    
    
    
  }
  # if EXPR realtime achived 0 and both cutters are in same lavel, then:
  # calc BG1 and 2 seperatly and take an average and report it for both BGs
  else{
    
    
    # for cutter 1
    ##############
    ##############
    ##############
    ##############
    cutter_wearflat_length[i,1] <- (BG[i,1]*Dc/8)/sin(pi*BR/180)*2.54
    colnames(cutter_wearflat_length) <- 'cutter_wearflat_length,cm'
    
    Tw[i,1] <- Tf[i,1]+((kf[i,1]*FN1[i,1]*Cutter_Velocity[i,1]*f[i,1])/(AwTotal[i,1]*6.4516))*
      ((1+(3*(pi^0.5)/4)*f[i,1]*khf[i,1]*(Cutter_Velocity[i,1]/(cutter_wearflat_length[i,1]*alpha_f[i,1]))^0.5)^-1)
    
    #============================================================wear function
    work1[i,1] <- (0.083*kf[i,1]*FN1[i,1]*RPM[i,1]*(2*pi*Re))*(DataTimeInter/60)
    work2[i,1] <- (0.083*Ce*AV_Matrix[i,1]*(2*pi*Re)*RPM[i,1]*CCS[i,1])*(DataTimeInter/60)
    workT[i,1] <- work1[i,1] + work2[i,1]
    alphaAve[i,1] <- (AwPDC/AwTotal)*wear_cof_PDC+(AwSTUD/AwTotal)*wear_cof_STUD
    cutter_worn_vol_each_datapoint[i,1] <- workT[i,1]/alphaAve[i,1]
    
    cwv <- cutter_worn_vol_each_datapoint[i,1]+ cwv
    comulative_cutter_worn_vol[i,1] <- cwv
    
    #calculate the BG by reverse cutter volume equation
    # wornVol_accuracy <- 0.001
    V_total_worn_theory <- 0
    
    while(V_total_worn_theory - comulative_cutter_worn_vol[i,1] < wornVol_accuracy){
      
      if (i==1){
        BG[i,1] <- BG[i,1] + addBG
        
        V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                       ((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))-
                                          ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                       ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
        
        cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
            "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
      } 
      else{
        BG[i,1] <- BG[i-1,1] + addBG 
        
        V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                       ((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))-
                                          ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                       ((1-((((Dc/2)-(BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
        
        cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
            "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
      }
    }
    
    
    
    
    
    
    
    
    
    
    #for cutter 2 or back up cutter
    ##############
    ##############
    ##############
    ##############
    if (DepthOfCut_P[i,1] > EXPR_new+BU_BGDc8Cos[i,1]){
      
      BU_cutter_wearflat_length[i,1] <- (BU_BG[i,1]*Dc/8)/sin(pi*BR/180)*2.54
      colnames(BU_cutter_wearflat_length) <- 'BU_cutter_wearflat_length,cm'
      
      BU_Tw[i,1] <- Tf[i,1]+((kf[i,1]*FN2[i,1]*Cutter_Velocity[i,1]*f[i,1])/(BU_AwTotal[i,1]*6.4516))*
        ((1+(3*(pi^0.5)/4)*f[i,1]*khf[i,1]*(Cutter_Velocity[i,1]/(BU_cutter_wearflat_length[i,1]*alpha_f[i,1]))^0.5)^-1)
      
      #============================================================wear function
      BU_work1[i,1] <- (0.083*kf[i,1]*FN2[i,1]*RPM[i,1]*(2*pi*Re))*(DataTimeInter/60)
      BU_work2[i,1] <- (0.083*Ce*BU_AV_Matrix[i,1]*(2*pi*Re)*RPM[i,1]*CCS[i,1])*(DataTimeInter/60)
      BU_workT[i,1] <- BU_work1[i,1] + BU_work2[i,1]
      BU_alphaAve[i,1] <- (BU_AwPDC/BU_AwTotal)*wear_cof_PDC+(BU_AwSTUD/BU_AwTotal)*wear_cof_STUD
      BU_cutter_worn_vol_each_datapoint[i,1] <- BU_workT[i,1]/BU_alphaAve[i,1]
      
      BU_cwv <- BU_cutter_worn_vol_each_datapoint[i,1]+ BU_cwv
      BU_comulative_cutter_worn_vol[i,1] <- BU_cwv
      
      #calculate the BU_BG by reverse cutter volume equation
      # wornVol_accuracy <- 0.001
      BU_V_total_worn_theory <- 0
      
      while(BU_V_total_worn_theory - BU_comulative_cutter_worn_vol[i,1] < wornVol_accuracy){
        
        if (i==1){
          BU_BG[i,1] <- BU_BG[i,1] + addBG
          
          BU_V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                            ((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))-
                                               ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                            ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
          
          cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
              "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        } 
        else{
          BU_BG[i,1] <- BU_BG[i-1,1] + addBG 
          
          BU_V_total_worn_theory <- (-1)*((((Dc/2)^3)/tan(pi*BR/180))*
                                            ((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2))*acos((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))-
                                               ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2))^0.5)+(((Dc/2)^3)/3*tan(pi*BR/180))*
                                            ((1-((((Dc/2)-(BU_BG[i,1]*Dc/8))/(Dc/2)))^2)^0.5)^3)
          
          cat("i==1 and For i=",i,"///   BG=",BG[i,1]," ///   CTWV=",comulative_cutter_worn_vol[i,1],
              "///   theoryV=",V_total_worn_theory,"///   diff=",V_total_worn_theory - comulative_cutter_worn_vol[i,1], "\n")
        }
      }
      
      
      
      #update BG and BU_BG by taking average of both
      
      BG[i+1,1] <- (BG[i,1]+BU_BG[i,1])/2
      BU_BG[i+1,1] <- (BG[i,1]+BU_BG[i,1])/2
      
      
    }
    else{
      
      BG[i+1,1] <- (BG[i,1]+BU_BG[i,1])/2
      BU_BG[i+1,1] <- (BG[i,1]+BU_BG[i,1])/2
    }
    
  }
  
  
  
  
  
  
  BGDc8[i+1,1] <- BG[i+1,1]*Dc/8
  BGDc8Cos[i+1,1] <- BGDc8[i+1,1]*cos(BR*pi/180)
  
  BU_BGDc8[i+1,1] <- BU_BG[i+1,1]*Dc/8
  BU_BGDc8Cos[i+1,1] <- BU_BGDc8[i+1,1]*cos(BR*pi/180)
  
  
  
}










#######################PLOTS
# #WOB
par(mfrow=c(1,6))
a <- data.frame(seq(1,Num_of_Data))
# #---------------------------------
plot(WOB[,1],a[,1], ylim = rev(range(a[,1])), ylab = "Depth ft", xlab = "", col="blue",
     pch=1,title(expression(main = "WOB (lbf)"), adj = 0.5, line = 2, col.main = "blue"),xlim = c(0,45000))
par(new=TRUE)
#CCS
plot(CCS[,1],a[,1], ylim = rev(range(a[,1])), axes=F, ylab = NA, xlab = NA,
     col="red",pch=1,title(expression(main = "CCS (psi)"), adj = 0.5, line = 0.7, col.main = "red"),xlim = c(0,50000))


# axis(side = 4)
# mtext(side = 4, line = 3, 'Number genes selected')
par(new=FALSE)


# #RPM
plot(RPM[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "",
     col="red",pch=1,title(expression(main = "RPM"), col.main = "red"),xlim = c(0,400))



#cutter_worn_vol_each_datapoint
plot(cutter_worn_vol_each_datapoint[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "",
     col="black",pch=1,title(expression(main = "Cutter worn volume each data point (in3)"), col.main = "black"))

par(new=TRUE)

plot(comulative_cutter_worn_vol[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "", axes=F,
     col="red",pch=1,title(expression(main = "Comulative cutter worn volume (in3)"), adj = 0.5, line = 0.7, col.main = "red"))



#ROP
plot(ROP[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "",
     col="black",pch=1,title(expression(main = "ROP (ft/hr)")),xlim = c(0,500))
par(new=FALSE)


#BG
plot(BG[1:99,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "",
     col="black",pch=1,title(expression(main = "Front Cutter BG"), col.main = "black"),xlim = c(0,10))

par(new=TRUE)
#BU_BG
plot(BU_BG[1:99,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "", axes=F,
     col="blue",pch=1,title(expression(main = "Back up Cutter BG"), adj = 0.5, line = 0.7, col.main = "blue"),xlim = c(0,10))
abline(v=8, col = "red", lty = 3)
par(new=FALSE)





#DOC_real
plot(DOC_real[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "",
     col="black",pch=1,title(expression(main = "Front cutter real depth of cut (in)"), adj = 0.5, line = 3.2, col.main = "black"))
par(new=TRUE)

#DOC_real
plot(BU_DOC_real[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "", axes=F,
     col="red",pch=1,title(expression(main = "Back Up cutter real depth of cut (in)"), adj = 0.5, line = 1.9, col.main = "red"))
par(new=TRUE)
# 
#EXPR_realtime
plot(EXPR_realtime[,1],a[,1], ylim = rev(range(a[,1])),ylab = "",xlab = "", axes=F,
     col="blue",pch=1,title(expression(main = "Real time Exposure (in)"), adj = 0.5, line = 0.7, col.main = "blue"),xlim = c(0,EXPR_new))








