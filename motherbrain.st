; Mother Brain States
; Normal States
;---------------------------------------------------------------------------
; Format:
; [Statedef STATENO]
; type = ?      S/C/A/L  stand/crouch/air/liedown
; movetype = ?  I/A/H    idle/attack/gethit
; physics = ?   S/C/A/N  stand/crouch/air/none
; juggle = ?             air juggle points move requires
;
; [State STATENO, ?]     ? - any number you choose
; type = ?
; ...

;---------------------------------------------------------------------------
; Lose by Time Over
; CNS difficulty: basic
[Statedef 170]
type = S
ctrl = 0
velset = 0,0

[State 170, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1

;---------------------------------------------------------------------------
; Win state decider
; CNS difficulty: basic
[Statedef 180]
type = S

[State 180, 1]
type = ChangeState
trigger1 = Time = 0
value = 181

;---------------------------------------------------------------------------
; Win pose 1
; CNS difficulty: basic
[Statedef 181]
type = S
ctrl = 0
velset = 0,0

[State 181, 1]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1


;---------------------------------------------------------------------------
; Introduction
; CNS difficulty: basic
[Statedef 190]
type = S
ctrl = 0

[State 190, 4] ;Change to stand state
type = ChangeState
trigger1 = 1
value = 0

;---------------------------------------------------------------------------
; Taunt
; CNS difficulty: easy
[Statedef 195]
type = S
movetype = I
ctrl = 0

[State 195, 2]
type = ChangeState
trigger1 = time = 1
value = 4500
ctrl = 1

; Mother Brain não é afetada a danos pequenos
[Statedef 200]
type = U
ctrl = 0
movetype = H

[State 200, LifeAdd]
type = LifeAdd
trigger1 = time = 0 && gethitvar(damage) && helper(4500), stateno = 704
value = GetHitVar(damage)-ifelse(random<200, 1, 0)
absolute = 1
ignorehitpause = 1

[State 200, LifeAdd]
type = LifeAdd
triggerall = numhelper(4500) && !time
trigger1 = helper(4500), var(54)
value = -(ceil(GetHitVar(damage)*(lifemax/1000.0))-GetHitVar(damage))
kill = 1
absolute = 0
ignorehitpause = 1

[State 200, ChangeState]
type = ChangeState
trigger1 = numhelper(2003) && time > 2 && helper(4500), stateno != 2002
value = 2010
ctrl = 0
ignorehitpause = 1

[State 200, HitOverride]
type = HitOverride
trigger1 = time = 0
attr = S,NA;,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 200
time = -1
forceair = 0
ignorehitpause = 1

;[State 200, LifeAdd]
;type = LifeAdd
;trigger1 = gethitvar(damage) < 50 && time = 0
;value = gethitvar(damage)
;absolute = 1
;ignorehitpause = 1

;[State 200, LifeAdd]
;type = LifeAdd
;trigger1 = gethitvar(damage) >= 50 && time = 0 && roundno > 1
;value = gethitvar(damage)/2
;absolute = 1
;ignorehitpause = 1

[State 200, VarSet]
type = VarSet
trigger1 = time = 0
v = 14
value = HitPauseTime
ignorehitpause =  1

[State 200, VarSet]
type = VarSet
trigger1 = gethitvar(damage)
v = 11
value = gethitvar(damage)
ignorehitpause =  1

[State 200, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(11) = %d"
params = var(11)
ignorehitpause = 1

[State 200, VarSet]
type = VarSet
trigger1 = gethitvar(damage); >= 50
v = 4
value = 1
ignorehitpause =  1

[State 200, PalFXWiz]
type = PalFX
trigger1 = gametime % 2 = 0 && Alive
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 200, PlaySnd]
type = PlaySnd
trigger1 = time = 0 && gethitvar(damage) && roundno <= 1
value = S200, 0
channel = -1
ignorehitpause = 1

[State 200, PlaySnd]
type = PlaySnd
triggerall = time = 0 && roundno > 1 && helper(4500), stateno != 704
trigger1 = gethitvar(damage) >= 100 || helper(4500), var(54)
value = S300, 0
channel = 0
ignorehitpause = 1

[State 200, VelSet]
type = VelSet
trigger1 = Alive && gethitvar(damage) && time = 0 && roundno >= 2 && !helper(4500), var(54) && helper(4500), stateno != 704
x = -abs(ifelse(abs(GetHitVar(xvel)) < 5, GetHitVar(xvel), ifelse(GetHitVar(xvel) < 0, -5, 5)));-(gethitvar(damage))/10
y = ifelse(abs(GetHitVar(yvel)) < 5, GetHitVar(yvel), ifelse(GetHitVar(yvel) < 0, -5, 5));-2
ignorehitpause = 1

[State 200, VelSet]
type = VelSet
trigger1 = Alive && gethitvar(damage) && time = 0 && roundno >= 2 && helper(4500), var(54)
x = -8*Const(size.xscale)
y = -5*Const(size.yscale)
ignorehitpause = 1

[State 200, VelSet]
type = VelMul
trigger1 = 1
x = 0.99
y = 0.99
ignorehitpause = 1

;[State 200, DisplayToClipboard]
;type = DisplayToClipboard
;trigger1 = numhelper(800) > 0
;text = "dist x %f dist y %f vel x %f vel y %f"
;params = (helper(800), pos x - pos x), (helper(800), pos y - pos y), vel x, vel y
;ignorehitpause = 1
;
[State 200, ChangeState]
type = ChangeState
;trigger1 = numhelper(800)
;trigger1 = (time > ifelse(var(14) > 25, var(14), 25) && ((helper(800), pos x - pos x) <= 10 && (helper(800), pos y - pos y) <=10)) || time > 60
;trigger2 = time > ifelse(var(14) > 25, var(14), 25)
trigger1 = (!helper(4500), var(54) && HitOver) || (helper(4500), var(54) && time > 50)
value = ifelse(alive, 0, 5050)
ctrl = 1
ignorehitpause = 1

[Statedef 201]
type = U
movetype = A
physics = U
hitdefpersist = 1
movehitpersist = 1
hitcountpersist = 1

[State 201, HitOverride]
type = HitOverride
trigger1 = !numhelper(2001)
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
stateno = 201
ignorehitpause = 1

[State 704, ModifyExplod]
type = ModifyExplod
trigger1 = var(13) < 2
ID = 9
bindtime = -1
removetime = var(52)+time+5
ignorehitpause = 1

[State 200, PalFXWiz]
type = PalFX
trigger1 = time % 2 = 0 && Alive
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 200, LifeAdd]
type = LifeAdd
trigger1 = time = 0 && gethitvar(damage)
value = GetHitVar(damage)-ifelse(random<200, 1, 0)
absolute = 1
ignorehitpause = 1

[State 200, ChangeState]
type = ChangeState
trigger1 = HitOver;time > ifelse(HitPauseTime > 25, HitPauseTime, 25)
value = 0

[Statedef 300]
type = A
movetype = A
physics = S
anim = 550

[State 300, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = unguardable
ignorehitpause = 1

[State 300, NotHitBy]
type = NotHitBy
trigger1 = !time
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1
persistent = 0

[State 300, PosFreeze]
type = PosSet
trigger1 = NumHelper(1000) > 0
x = (helper(1000), Pos X+(75*facing)*Const(size.xscale))
y = (helper(1000), Pos Y-50*Const(size.yscale))
ignorehitpause = 1

[State 300, PlayerPush]
type = PlayerPush
trigger1 = enemynear, Pos Y > Pos Y
value = 1
ignorehitpause = 1

[State 1000, SprPriority]
type = SprPriority
trigger1 = 1
value = -2
ignorehitpause = 1

[State 300, HitOverride]
type = HitOverride
trigger1 = time = 0
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 300
time = -1
forceair = 0
ignorehitpause = 1

[State 300, ChangeAnim]
type = ChangeAnim
trigger1 = anim != 300
value = 300
ignorehitpause = 1

[State 300, StateTypeSet]
type = StateTypeSet
trigger1 = anim = 300
movetype = I
ignorehitpause = 1

[State 300, VarSet]
type = VarSet
trigger1 = var(20)
v = 20
value = 0
ignorehitpause = 1

[State 300, ChangeAnim]
type = ChangeAnim
triggerall = anim != [550, 551]
trigger1 = enemyNear,Vel Y > 0 && roundstate = 2 && enemyNear,Pos Y = [Pos Y-10,Pos Y+1]
trigger1 = enemyNear,Pos X >= Pos X-Const(size.ground.back) && EnemyNear, Pos X <= Pos X+Const(size.ground.front) && var(20) := 1
trigger2 = (enemyNear,StateType = S && enemyNear,Pos Y = Pos Y  && enemyNear,Vel Y = 0)
trigger2 = (enemyNear,Pos X < Pos X-Const(size.ground.back) || EnemyNear, Pos X > Pos X+Const(size.ground.front)) && abs(enemyNear,Vel X) > 0 && var(20) := 2
trigger3 = roundstate != 2 && lose && var(20) := 2 && enemynear, pos y <= pos y && enemynear, statetype != A
value = 549+var(20)
ignorehitpause = 1

[State 300, StateTypeSet]
type = StateTypeSet
trigger1 = var(20)
movetype = A
ignorehitpause = 1

[State 300, LandOnBlock]
type = Hitdef
trigger1 = var(20) = 1
;trigger2 = Facing = -1 && enemyNear,Pos X >= Pos X-Const(size.ground.back) && EnemyNear, Pos X <= Pos X+Const(size.ground.front)
attr = A,NT
hitflag = HLAFD
priority = 1, Miss
damage = 0,0
sparkno = -1
p2stateno = 400
kill = 0
guard.dist = 0
postype = p1
fall.damage = floor(Pos Y)
numhits = 0

[State 300, FallFromBlock]
type = Hitdef
trigger1 = var(20) = 2
;trigger2 = Facing = -1 && (enemyNear,Pos X < Pos X-Const(size.ground.back) || EnemyNear, Pos X > Pos X+Const(size.ground.front)) && abs(enemyNear,Vel X) > 0
;trigger2 = roundstate != 2 && lose
attr = S,NT
hitflag = HLAFD
priority = 1, Miss
damage = 0,0
sparkno = -1
p2stateno = 401
kill = 0
guard.dist = 0
postype = p1
numhits = 0

;[State 300, Explod]
;type = Explod
;trigger1 = roundstate != 2 && lose
;anim = 2
;ID = 2
;pos = 0,0
;bindtime = 1
;removetime = -2
;scale = Const(size.xscale), Const(size.yscale)
;sprpriority = 4
;shadow = 0,0,0
;ownpal = 1
;removeongethit = 0
;ignorehitpause = 1

[State 300, DestroySelf]
type = DestroySelf
triggerall = roundstate != 2 && lose
trigger1 = (enemyNear,StateType = S && enemyNear,Pos Y = Pos Y  && enemyNear,Vel Y = 0)
trigger1 = (enemyNear,Pos X < Pos X-Const(size.ground.back) || EnemyNear, Pos X > Pos X+Const(size.ground.front)) && abs(enemyNear,Vel X) > 0 && movecontact
trigger2 = !numhelper(1000)
ignorehitpause = 1

;--------------------------------------------------------------------------
; Player 2 - Land
[Statedef 400]
type = S
physics = S

;Stop
[State 400, StopVel]
type = VelSet
trigger1 = Time = 0
Y = 0

;Center
[State 400, Center]
type = PosSet
trigger1 = Time = 0
Y = GetHitVar(fall.damage)

;Land sound
[State 400, LandSound]
type = PlaySnd
trigger1 = Time = 0
value = 52,0

[State 400, ChangeAnim]
type = ChangeAnim
trigger1 = Time = 0 && SelfAnimExist(47)
value = 47
ignorehitpause = 1

[State 400, Land]
type = SelfState
trigger1 = ((anim = 47 && animtime = 0) || (!selfanimexist(47)))
value = 0
ctrl = 1

;--------------------------------------------------------------------------
; Player 2 - Fall off of Block
[Statedef 401]
type = A
physics = A

;Change to jump down state
[State 401, JumpDown]
type = SelfState
trigger1 = Time = 0
value = 50
ctrl = 1

; Olho
[Statedef 500]
type = S
movetype = I
physics = N
anim = 500
ctrl = 0
sprpriority = -1

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

[State 500, ChangeAnim]
type = ChangeAnim
triggerall = anim != 504 && roundno > 1
trigger1 = roundstate = 3 && win
trigger2 = helper(4500), stateno = 2006 && helper(4500), var(0) >= 6
value = 504
ignorehitpause = 1

[State 500, ChangeAnim]
type = ChangeAnim
triggerall = anim != 503 && helper(4500), ctrl && alive
trigger1 = time % 60 = 0 && anim = 502
trigger2 = helper(4500), prevstateno = 2006
value = 503
ignorehitpause = 1

[State 500, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 503 && animtime = 0
value = 502
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

[State 500, NotHitBy]
type = NotHitBy
trigger1 = time = 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1

[State 500, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "root, numprojid(701) %d"
params = numprojid(701)
ignorehitpause = 1

[State 500, ChangeAnim]
type = ChangeAnim
trigger1 = helper(4500), stateno = 701 && anim != 502 || (!root, Alive && anim = 503)
value = 502
ignorehitpause = 1

[State 500, Projectile]
type = Projectile
trigger1 = helper(4500), stateno = 701 && root, numprojid(701) = 0 && helper(4500), time <= 1
ProjID = 701
projanim = 61
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = Const(size.xscale),Const(size.yscale)
projremove = 1
projremovetime = -1
velocity = 2*Const(size.xscale),0
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = -5
projedgebound = 200
projstagebound = 200
projheightbound = -357
offset = floor(17*Const(size.xscale)),floor(-16*Const(size.yscale))
postype = p1         ;p2,front,back,left,right
projshadow = 0,0,0
supermovetime = 0
pausemovetime = 0
; HitDef
attr = S,SP        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
getpower = 0,0
givepower = 0,0
animtype = light          ;light,medium,hard,back,up,diagup
air.animtype = light
priority = 4,Hit   ;Hit,Miss,Dodge
damage = ifelse(!helper(4500), var(54), 25, 15),0
pausetime = 0,0
sparkno = 0
sparkxy = 0,0
hitsound = 0,0
guardsound = 0,0
ground.type = High      ;Low,Trip,None
ground.slide = 0
ground.hit = 0
air.hittime = 20
guard.dist = 0
ground.velocity = 0,0
air.velocity = 0,0
p1getp2facing = 0
fall = 0
down.bounce = 0
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 1
palfx.time = 2
palfx.mul = 256,256,256
palfx.add = 256,256,256


; Abrir olho quando
[State 500, VarSet]
type = VarSet
triggerall = !var(0) && numhelper(60) && !(helper(4500), stateno = 2006 && helper(4500), var(0) >= 6)
triggerall = helper(60), Pos Y <= 0
trigger1 = helper(4500), stateno = 181
trigger2 = roundno > 1 && root, Alive && helper(4500), stateno != 704
trigger3 = helper(4500), stateno = 701
trigger4 = helper(4500), stateno = 704 && helper(4500), var(13) = 2 && root, numhelper(705)
v = 0
value = 1
ignorehitpause = 1

; Fechar olho quando
[State 500, VarSet]
type = VarSet
triggerall = var(0) && roundno > 1 && !(helper(4500), stateno = 2006 && helper(4500), var(0) >= 6)
trigger1 = !root, Alive && numhelper(50) <= 0
trigger2 = helper(4500), stateno = 704 && helper(4500), var(13) = 0
trigger3 = numhelper(60)
trigger3 = helper(60), Pos Y > 0
v = 0
value = 0
ignorehitpause = 1

[State 500, BindToRoot]
type = BindToRoot
trigger1 = time = 0
time = -1
facing = 1
pos = 0,0
ignorehitpause = 1

[State 500, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1
persistent = 2

[State 500, ChangeAnim]
type = ChangeAnim
trigger1 = var(0) && anim = 500
trigger2 = !var(0) && anim = 502
value = 501
ignorehitpause = 1

[State 500, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 501 && animtime = 0
value = ifelse(var(0), 502, 500)
ignorehitpause = 1

[State 500, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

; Boca
[Statedef 600]
type = S
movetype = I
physics = N
anim = 600
ctrl = 0
sprpriority = -1

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

[State 600, Helper]
type = Helper
trigger1 = helper(4500), stateno = 702 && root, numhelper(1007) <= 0 && anim = 603
helpertype = normal ;player
name = "Bomba"
ID = 1007
stateno = 1007
pos = 0,floor(7*Const(size.yscale))
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
ignorehitpause = 1
size.ground.back = 3
size.ground.front = 3
size.air.back = 3
size.air.front = 3

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

[State 600, BindToRoot]
type = BindToRoot
trigger1 = time = 0
time = -1
facing = 1
pos = 0,0
ignorehitpause = 1

[State 600, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1
persistent = 2

; Bia's Code
[State 600, Componente X]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2 && helper(4500), stateno != 2006
triggerall = !(!enemynear(0), alive && numenemy = 1)
Trigger1 = time % 4 = 0 && roundstate = 2
fvar(13)=(EnemyNear(ifelse(enemynear(0),alive,0,1)),Pos X+(EnemyNear(ifelse(enemynear(0),alive,0,1)),Const(size.mid.pos.x)*EnemyNear(ifelse(enemynear(0),alive,0,1)),facing)-(Pos X+(10*Const(size.xscale)*Facing)))*Facing ;Ajusta a direção da componente por facing

[State 600, Componente Y]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2 && helper(4500), stateno != 2006
triggerall = !(!enemynear(0), alive && numenemy = 1)
trigger1 = time % 4 = 0 && roundstate = 2
fvar(14) = (EnemyNear(ifelse(enemynear(0), alive, 0, 1)), pos Y+EnemyNear(ifelse(enemynear(0), alive, 0, 1)), Const(size.mid.pos.y) - (Pos Y-1))

[State 600, Componente X]
Type = VarSet
triggerall = numhelper(2001) && helper(4500), stateno = 2006
Trigger1 = time % 4 = 0 && roundstate = 2
fvar(13)=  (helper(2001),Pos X+helper(2001),Const(size.mid.pos.x)*helper(2001),facing)-(Pos X+(10*Facing));*Facing ;Ajusta a direção da componente por facing

[State 600, Componente Y]
Type = VarSet
triggerall = numhelper(2001) && helper(4500), stateno = 2006
trigger1 = time % 4 = 0 && roundstate = 2
fvar(14) = (helper(2001),Pos Y+((helper(2001), Const(size.mid.pos.y))*(helper(2001), Const(size.yscale))) - (Pos Y-1))


[State 600, Normal]
Type = VarSet
triggerall = time % 4 = 0 && roundstate = 2
trigger1 = numenemy > 0 && numenemy <= 2 && helper(4500), stateno != 2006
trigger1 = !(!enemynear(0), alive && numenemy = 1)
trigger2 = numhelper(2001) && helper(4500), stateno = 2006
fvar(15) = Exp(0.5*ln((fvar(13) * fvar(13))+(fvar(14) * fvar(14))))

[State 704, PlaySnd]
type = PlaySnd
trigger1 = helper(4500), stateno = 2002 && root, life <= root, lifemax/4
value = S300, 0
ignorehitpause = 1
persistent = 0

[State 704, PlaySnd]
type = PlaySnd
trigger1 = helper(4500), stateno = 2006 && helper(4500), var(0) = 2
value = S300, 0
ignorehitpause = 1
persistent = 0

[State 600, ChangeAnim]
type = ChangeAnim
trigger1 = helper(4500), stateno = 2006 && helper(4500), var(0) = 2
value = 601
ignorehitpause = 1
persistent = 0

[State 600, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 602 && animtime = 0
value = 603
ignorehitpause = 1

[State 600, ChangeAnim]
type = VarSet
trigger1 = anim = 604 && animtime = 0
v = 0
value = 0
ignorehitpause = 1

[State 600, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 604 && animtime = 0
value = 600
ignorehitpause = 1

[State 600, Projectile]
type = VarAdd
triggerall = anim = 603 && numhelper(4500)
trigger1 = helper(4500), stateno = 700 && !(time % 4)
trigger2 = helper(4500), stateno = 702 && numhelper(1007) && !var(0)
trigger2 = helper(1007), time > 50
trigger3 = numhelper(2001) && helper(4500), stateno = 2006
trigger3 = (helper(4500), var(0) = 4 || (helper(4500), var(0) = 6 && helper(2001), time-helper(2001), var(10) >= 200)) && !(time % 4)
v = 0
value = 1

[State 600, Projectile]
type = PowerAdd
trigger1 = anim = 603 && helper(4500), stateno = 700 && !(time % 4)
value = -100

[State 600, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "facing = %d"
params = facing
ignorehitpause = 1

[State 600, Projectile]
type = Projectile
trigger1 = numhelper(4500)
trigger1 = anim = 603 && helper(4500), numprojid(700) < 4 && !(time % 4) && fvar(15) != 0 && helper(4500), stateno = 700
ProjID = 700
projanim = 60
projhitanim = -1
projremanim = 2
projcancelanim = -1
projremove = 1
projremovetime = -1
velocity = (Fvar(13)/fvar(15)) * (3.0*Const(size.xscale)),(FVar(14)/fvar(15)) * (3.0*Const(size.yscale))
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -357
projscale = Const(size.xscale), Const(size.yscale)
offset = floor(10*Const(size.xscale)),floor(-1*Const(size.yscale))
postype = p1         ;p2,front,back,left,right
projshadow = 0,0,0
supermovetime = 0
pausemovetime = 0
; HitDef
attr = S,SP        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MLAFD        ;HLAFD+-
guardflag = MA         ;HLA
getpower = 15,0
givepower = 2,1
animtype = hard          ;light,medium,hard,back,up,diagup
air.animtype = hard
priority = 4,Hit   ;Hit,Miss,Dodge
damage = ifelse(!helper(4500), var(54), 50, 10),ifelse(!helper(4500), var(54), 10, 0)
pausetime = 0,ifelse(!helper(4500), var(54), 20, 0)
sparkno = S2
sparkxy = 0,0
hitsound = S100,0
ground.type = Trip      ;Low,Trip,None
ground.slide = 0
ground.hit = 0
air.hittime = 20
ground.velocity = -15,-5
air.velocity = -15,-5
sprpriority = 1
p1getp2facing = 0
fall = ifelse(!helper(4500), var(54), 1, 0)
fall.recover = ifelse(!helper(4500), var(54), 0, 1)
kill = 1
guard.kill = ifelse(!helper(4500), var(54), 1, 0)
fall.kill = 1
numhits = 1

[State 600, Projectile]
type = Projectile
triggerall = anim = 603 && var(0) <= 4 && !(time % 4) && fvar(15) != 0 && helper(4500), stateno = 2006 && numhelper(2001)
trigger1 = helper(4500), var(0) = 4 || (helper(2001), var(10) && helper(4500), var(0) = 6 && helper(2001), time-helper(2001), var(10) >= 200)
ProjID = 760
projanim = 60
projhitanim = -1
projremanim = 2
projcancelanim = -1
projremove = 1
projremovetime = -1
projscale = Const(size.xscale), Const(size.yscale)
velocity = (Fvar(13)/fvar(15)) * (3.0*Const(size.xscale))*facing,(FVar(14)/fvar(15)) * (3.0*Const(size.yscale))
;velocity = ((Fvar(13)/fvar(15)) * (3.0*Const(size.xscale)))*root,facing,(FVar(14)/fvar(15)) * (3.0*Const(size.yscale))
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -357
offset = floor(10*Const(size.xscale)),floor(-1*Const(size.yscale))
postype = p1         ;p2,front,back,left,right
projshadow = 0,0,0
supermovetime = 0
pausemovetime = 0
; HitDef
attr = S,SP        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MLAFD        ;HLAFD+-
guardflag = MA         ;HLA
getpower = 15,0
givepower = 2,1
affectteam = B
animtype = hard          ;light,medium,hard,back,up,diagup
air.animtype = hard
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 30,5
pausetime = 0,20
sparkno = S2
sparkxy = 0,0
hitsound = S100,0
ground.type = Trip      ;Low,Trip,None
ground.slide = 0
ground.hit = 0
air.hittime = 20
ground.velocity = -15,-5
air.velocity = -15,-5
air.juggle = 10
sprpriority = 1
p1getp2facing = 0
fall = ifelse(!helper(4500), var(54), 1, 0)
kill = ifelse(helper(4500), var(0) < 6, 0, 1)
guard.kill = 0
fall.kill = 0
numhits = 1

[State 700, PlaySnd]
type = PlaySnd
trigger1 = anim != 602 && numhelper(2001) && helper(4500), stateno = 2006 && !var(0)
trigger1 = ((helper(4500), var(0) = 4 && time % 70 = 0) || (helper(2001), var(10) && helper(4500), var(0) = 6 && helper(2001), time-helper(2001), var(10) >= 200))
value = S700,0
ignorehitpause = 1

; Abrir boca
[State 600, ChangeAnim]
type = ChangeAnim
triggerall = anim = 600 && numhelper(4500)
trigger1 = (helper(4500), stateno = 700 || helper(4500), stateno = 702) && !var(0)
trigger2 = (root, life < root, lifemax/4 && root, life >= root, lifemax/6) && helper(4500), stateno = 2002
trigger3 = numhelper(2001) && helper(4500), stateno = 2006 && !var(0)
trigger3 = ((helper(4500), var(0) = 4 && time % 70 = 0) || (helper(2001), var(10) && helper(4500), var(0) = 6 && helper(2001), time-helper(2001), var(10) >= 200))
value = 602
ignorehitpause = 1

; Fechar Boca
[State 600, ChangeAnim]
type = ChangeAnim
triggerall = anim = 603 && numhelper(4500)
trigger1 = var(0) >= 4 && (helper(4500), stateno = 700 || (helper(4500), stateno = 2006 && (helper(4500), var(0) = 4 || helper(4500), var(0) = 6)))
trigger2 = var(0) && helper(4500), stateno = 702
trigger3 = helper(4500), stateno != 700 && helper(4500), stateno != 702 && helper(4500), stateno != 2002 && !(helper(4500), stateno = 2006 && (helper(4500), var(0) = 0 || helper(4500), var(0) = 4 || helper(4500), var(0) = 6))
trigger4 = (root, life > root, lifemax/4 || root, life < 0) && helper(4500), stateno = 2002
value = 604
ignorehitpause = 1

[State 600, ChangeAnim]
type = ChangeAnim
triggerall = anim = 600
trigger1 = (root, stateno = 181 && root, time <= 5) || (helper(4500), stateno = 195 && helper(4500), time <= 5)
value = 601
ignorehitpause = 1

[State 601, PlaySnd]
type = PlaySnd
trigger1 = anim = 601 && animelem = 1
value = S300,0
volume = 0
channel = 0
ignorehitpause = 1

[State 601, ChangeAnim]
type = ChangeAnim
trigger1 = animtime = 0 && anim = 601
value = 600

[State 600, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

[Statedef 700]
type = U
movetype = A
ctrl = 0

[State 700, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 700, PlaySnd]
type = PlaySnd
trigger1 = time = 0
value = S700,0
ignorehitpause = 1

[State 700, PlaySnd]
type = PlaySnd
trigger1 = time = 0 && random <= 250
value = S702,0
ignorehitpause = 1

[State 700, ChangeState]
type = ChangeState
trigger1 = helper(600), var(0) >= 4
value = 4500
ctrl = 1

[Statedef 701]
type = U
movetype = A
ctrl = 0
poweradd = 30

[State 701, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 701, PlaySnd]
type = PlaySnd
trigger1 = time = 0
value = S701,0
channel = -1
ignorehitpause = 1

[State 701, ChangeState]
type = ChangeState
trigger1 = time > 60
value = 4500
ctrl = 1

[Statedef 702]
type = U
movetype = A
ctrl = 0
poweradd = 30

[State 702, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 702, PlaySnd]
type = PlaySnd
trigger1 = time = 0
value = S702,0
channel = 0
ignorehitpause = 1

[State 702, ChangeState]
type = ChangeState
trigger1 = helper(600), var(0)
value = 4500
ctrl = 1

[Statedef 703]
type = U
movetype = A
ctrl = 0
poweradd = -300

[State 703, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 703, ChangeState]
type = ChangeState
trigger1 = helper(50), anim = 40 && time > 10 && numhelper(1008) <= 0
value = 4500
ctrl = 1

[Statedef 704]
type = U
movetype = A
ctrl = 0

[State 704, ChangeState]
type = ChangeState
trigger1 = root, stateno = 2010
value = 2002
ctrl = 0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 704, PalFXWiz]
type = PalFX
trigger1 = time % 15 = 0 && root, Alive && !var(4) && var(13) < 2
time = 15
add = 30,30,30
mul = 256,256,256
sinadd = 30,30,30,15
color = 256
ignorehitpause = 1

[State 15963, HitAdd]
type = HitAdd
trigger1 = hitcount < 999
value = 1
ignorehitpause = 1

[State 704, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = unguardable
flag2 = timerfreeze
ignorehitpause = 1

[State 704, PlaySnd]
type = PlaySnd
trigger1 = numtarget && time % 15 = 0
value = S100,0
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0 && var(52) && prevstateno != 704 && prevstateno != 201
v = 52
value = 0
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0 && var(13) && !var(14)
v = 13
value = 0
ignorehitpause = 1

[State 704, VarSet]
type = VarAdd
trigger1 = 1
v = 14
value = 1
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0
v = 40
value = 255
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0
v = 41
value = 0
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0
v = 42
value = 0
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = time = 0
v = 43
value = 0
ignorehitpause = 1

[State 704, VarAdd]
type = VarAdd
triggerall = var(13) >= 2 && numhelper(705)
trigger1 = var(43) = 0 && var(40) >= 255 && var(42) <= 0
trigger2 = var(43) = 1 && var(41) >= 255 && var(40) >= 255
trigger3 = var(43) = 2 && var(41) >= 255 && var(40) <= 0
trigger4 = var(43) = 3 && var(42) >= 255 && var(41) >= 255
trigger5 = var(43) = 4 && var(42) >= 255 && var(41) <= 0
trigger6 = var(43) = 5 && var(42) >= 255 && var(40) >= 255
v = 43
value = 1
ignorehitpause = 1

[State 704, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = var(13) >= 2
text = "%d %d %d %d"
params = var(40),var(41),var(42), var(43)
ignorehitpause = 1

[State 704, PalFX]
type = PalFX
trigger1 = var(13) >= 2 && numhelper(705)
time = 1
add = 128-var(40),128-var(41),128-var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 704, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 704, VarAdd]
type = VarAdd
trigger1 = var(13) >= 2 && numhelper(705)
v = 40+ifelse(var(43) = 1, 1, ifelse(var(43) = 3, 2, ifelse(var(43) = 5, 0, 6)))
value = 20
ignorehitpause = 1

[State 704, VarAdd]
type = VarAdd
trigger1 = var(13) >= 2 && numhelper(705)
v = 40+ifelse(var(43) = 0, 2, ifelse(var(43) = 2, 0, ifelse(var(43) = 4, 1, 6)))
value = -20
ignorehitpause = 1

[State 704, VarSet]
type = VarSet
trigger1 = var(43) >= 6
v = 43    ;fv = 10
value = 0
ignorehitpause = 1

[State 704, Explod]
type = Explod
trigger1 = time = 0 && !numexplod(9)
anim = 9
ID = 9
pos = 0,-20
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = -1
vel = 0,0
accel = 0,0
random = 0,0
removetime = 20
ontop = 1
shadow = -1,-1,-1
ownpal = 1
ignorehitpause = 1

[State 704, ModifyExplod]
type = ModifyExplod
trigger1 = var(13) < 2
ID = 9
bindtime = -1
removetime = var(52)+5
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = !numenemy
v = 24
value = -1

[State 704, VarSet]
type = VarSet
trigger1 = numenemy = 1
v = 24
value = ifelse(enemynear,alive,0,-1)

[State 704, VarSet]
type = VarSet
trigger1 = numenemy = 2
v = 24
value = ifelse(enemynear(0),alive, 0, ifelse(enemynear(1),alive,1,-1))
ignorehitpause = 1

[State 704, Helper]
type = Helper
triggerall = var(24) >= 0
triggerall = enemynear(var(24)), stateno = 15964
trigger1 = !numhelper(2001) && !numhelper(705) && var(14) > 240 && var(13) >= 1 && enemynear(var(24)), life <= floor(enemynear(var(24)), lifemax/4)
helpertype = normal
name = "Super Metroid"
ID = 2001
stateno = 2001
pos = floor(400*Const(size.xscale)),floor(-300*Const(size.yscale))
facing = 1
keyctrl = 0
ownpal = 1
ignorehitpause = 1
persistent = 0

[State 704, Explod]
type = Helper
triggerall = var(24) >= 0
trigger1 = var(13) >= 2 && !numhelper(705) && !numhelper(2001)
helpertype = normal ;player
name = "Ultra Shiny Laser"
ID = 705
stateno = 705
pos = 0,0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = 1
size.yscale = 1

[State 704, PlaySnd]
type = PlaySnd
trigger1 = time < 240 && var(13) < 2 && prevstateno != 201
value = S704,0
channel = 3
ignorehitpause = 1
loop = 1
persistent = 0

[State 704, StopSnd]
type = StopSnd
trigger1 = var(13) >= 2 && numhelper(705)
channel = 3
ignorehitpause = 1
persistent = 0

[State 704, PlaySnd]
type = PlaySnd
trigger1 = var(13) >= 2 && numhelper(705)
value = S704,1
channel = 3
loop = 1
ignorehitpause = 1
persistent = 0

[State 704, PowerAdd]
type = PowerAdd
trigger1 = var(13) < 1 && time % 2 = 0
value = 28
ignorehitpause = 1

[State 704, PlaySnd]
type = VarSet
trigger1 = var(14) > 240 && !var(13)
v = 13
value = 1
ignorehitpause = 1

[State 704, PlaySnd]
type = VarSet
trigger1 = var(14) > 280 && var(13) = 1
v = 13
value = 2
ignorehitpause = 1

[State 704, PowerAdd]
type = PowerAdd
trigger1 = var(13) >= 2 && var(14) % 2 = 0 && numhelper(705)
value = -12
ignorehitpause = 1

[State 704, ChangeState]
type = VarSet
trigger1 = (!power && var(13) >= 2) || roundstate != 2
v = 14
value = 0

[State 704, VarAdd]
type = VarAdd
trigger1 = 1
v = 52
value = 1
ignorehitpause = 1

[State 704, StopSnd]
type = StopSnd
trigger1 = !power || roundstate != 2
channel = 3
ignorehitpause = 1
persistent = 0

[State 704, ChangeState]
type = ChangeState
trigger1 = ((!power && var(13) >= 2) || roundstate != 2)
value = 4500
ctrl = 1

[Statedef 705]
type = A
movetype = A
physics = N
anim = 13
ctrl = 0

[State 705, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = unguardable
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = !numenemy
v = 48    ;fv = 10
value = -1

[State 705, VarSet]
type = VarSet
trigger1 = numenemy = 1
v = 48    ;fv = 10
value = ifelse(enemynear,alive,0,-1)

[State 705, VarSet]
type = VarSet
trigger1 = numenemy = 2
v = 48    ;fv = 10
value = ifelse(enemynear(0),alive, 0, ifelse(enemynear(1),alive,1,-1))
ignorehitpause = 1

; Bia's Code
[State 1003, Componente X]
Type = VarSet
triggerall = var(48)>= 0
trigger1 = roundstate = 2
fvar(13) = (EnemyNear(var(48)), Pos X+(EnemyNear(var(48)),Const(size.mid.pos.x)*EnemyNear(var(48)),facing)- Pos X) * Facing ;Ajusta a direção da componente por facing

[State 1003, Componente Y]
Type = VarSet
triggerall = var(48)>= 0
trigger1 = roundstate = 2
fvar(14) = (EnemyNear(var(48)), pos Y+EnemyNear(var(48)),Const(size.mid.pos.y) - Pos Y)

[State 1003, Normal]
Type = VarSet
triggerall = var(48)>= 0
trigger1 = roundstate = 2
fvar(15) = Exp(0.5*ln((fvar(13) * fvar(13))+(fvar(14) * fvar(14))))

[State 705, PosSet]
type = PosSet
trigger1 = 1
x = helper(500), pos x + (16*facing)*helper(500), Const(size.xscale)
y = helper(500), pos y - 15*helper(500), Const(size.yscale)
ignorehitpause = 1

[State 705, M]
Type = VarSet
trigger1 = var(48)>= 0
fvar(11) = (ifelse(facing = 1, Pos Y-(Enemynear(var(48)), pos y+enemynear(var(48)),Const(size.mid.pos.y)), (Enemynear(var(48)), pos y+enemynear(var(48)),Const(size.mid.pos.y))-pos y))/(Enemynear(var(48)), Pos X-Pos X)


;[State 705, M]
;Type = VarSet
;trigger1 = EnemyNear(0), Pos X = Pos X
;fvar(11) = 0

[State 705, Angle]
Type = VarSet
triggerall = var(48)>= 0
trigger1 = enemynear(var(48)), pos x >= pos x && facing = 1
trigger2 = enemynear(var(48)), pos x < pos x && facing = -1
fv = 12
value = atan(fvar(11))

[State 705, Angle]
Type = VarSet
triggerall = var(48)>= 0
trigger1 = enemynear(var(48)), pos x >= pos x && facing = -1
trigger2 = enemynear(var(48)), pos x < pos x && facing = 1
fv = 12
value = atan(fvar(11))+pi

[State 705, AngleSet]
type = AngleSet
trigger1 = var(48)>= 0
value = (fvar(12)*(180/PI));*ifelse(facing, -1, 1)
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 0
value = 255
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 1
value = 0
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 2
value = 0
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 3
value = 0
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
trigger1 = var(3) = 0 && var(0) >= 255 && var(2) <= 0
trigger2 = var(3) = 1 && var(1) >= 255 && var(0) >= 255
trigger3 = var(3) = 2 && var(1) >= 255 && var(0) <= 0
trigger4 = var(3) = 3 && var(2) >= 255 && var(1) >= 255
trigger5 = var(3) = 4 && var(2) >= 255 && var(1) <= 0
trigger6 = var(3) = 5 && var(2) >= 255 && var(0) >= 255
v = 3
value = 1
ignorehitpause = 1

[State 705, EnvShake]
type = EnvShake
trigger1 = time % 60 = 0
time = 60
freq = 60
ampl = -5
phase = 90
ignorehitpause = 1

[State 705, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = 220, 255
ignorehitpause = 1

[State 705, PalFX]
type = PalFX
trigger1 = 1
time = 1
add = var(0),var(1),var(2)
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
trigger1 = 1
v = ifelse(var(3) = 1, 1, ifelse(var(3) = 3, 2, ifelse(var(3) = 5, 0, 6)))
value = 20
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
trigger1 = 1
v = ifelse(var(3) = 0, 2, ifelse(var(3) = 2, 0, ifelse(var(3) = 4, 1, 6)))
value = -20
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = var(3) >= 6
v = 3    ;fv = 10
value = 0
ignorehitpause = 1

[State 705, AngleDraw]
type = AngleDraw
trigger1 = 1
ignorehitpause = 1

[State 705, Projectile]
type = Projectile
triggerall = var(48)>= 0 && root, power
trigger1 = time % 3 = 0 ;&& EnemyNear(var(48)), stateno != 15963 && EnemyNear(var(48)), stateno != 707
ProjID = 100
projanim = 65
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = 1,1
projremove = 1
projremovetime = 120
velocity = cos(fvar(12))*20, sin(fvar(12)+PI)*20
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 999
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = floor(80*Const(size.xscale))
projstagebound = floor(80*const(size.yscale))
projheightbound = -313
offset = 0,0
postype = p1         ;p2,front,back,left,right
; HitDef
attr = S,HA        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = HLAFD        ;HLAFD+-
guardflag = L         ;HLA
getpower = 0,0
givepower = 0,0
;affectteam = E          ;B,E,F
animtype = Hard          ;light,medium,hard,back,up,diagup
air.animtype = Hard
priority = 7,Hit   ;Hit,Miss,Dodge
damage = 10,10
pausetime = 0,0
ground.type = Trip      ;Low,Trip,None
ground.velocity = -15, -2
air.velocity = -15, -2
airguard.velocity = -15, -2
hitsound = S100,0
guardsound = -1
id = 704
fall = 0
p2facing = 1
p2stateno = 15963
numhits = 2

[State 704, DestroySelf]
type = DestroySelf
trigger1 = helper(4500), stateno != 704
ignorehitpause = 1

; Caindo do ultra dano
[Statedef 15964]
type = A
movetype = H
physics = N
ctrl = 0
sprpriority = -4

[State 15964, VelSet]
type = VelSet
trigger1 = time = 0
x = 7
ignorehitpause = 1

[State 15964, VelMul]
type = VelMul
trigger1 = 1
x = 0.2
ignorehitpause = 1

[State 15964, Gravity]
type = Gravity
trigger1 = Pos Y < 0
ignorehitpause = 1

[State 15964, StateTypeSet]
type = StateTypeSet
trigger1 = Pos Y >= 0
statetype = C       ;S,A,C,L
movetype = I        ;I,A,H
physics = C         ;A,C,S,N
ignorehitpause = 1

[State 15964, StateTypeSet]
type = StateTypeSet
trigger1 = !Alive
movetype = I        ;I,A,H
ignorehitpause = 1

[State 15964, StateTypeSet]
type = VelSet
trigger1 = Pos Y > 0
y = 0
ignorehitpause = 1

[State 15964, StateTypeSet]
type = PosSet
trigger1 = Pos Y > 0
y = 0
ignorehitpause = 1

[State 15964, ChangeAnim]
type = ChangeAnim
triggerall = selfanimexist(5300) || selfanimexist(5000)
trigger1 = Pos Y >= 0 && anim != ifelse(selfanimexist(5300), 5300,5000)
value = ifelse(selfanimexist(5300), 5300,5000)
ignorehitpause = 1

[State 15964, SelfState]
type = SelfState
trigger1 = !alive || roundstate != 2
value = 5000
ignorehitpause = 1

[State 15964, SelfState]
type = SelfState
triggerall = time > 160 && (pos Y >= 0 && life >= lifemax/4 || time > 3500)
trigger1 = command = "fwd" || command = "back" || command = "down" || command = "up"
value = 11
ctrl = 1
ignorehitpause = 1

; Orientador da cabeça
[Statedef 800]
type = S
movetype = I
physics = N
anim = -1
ctrl = 0

[State 800, PosSet]
type = PosSet
trigger1 = pos y > 0
y = 0
ignorehitpause = 1

[State 800, DestroySelf]
type = DestroySelf
trigger1 = numhelper(50) <= 0
ignorehitpause = 1

[State 800, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = invisible
ignorehitpause = 1

[State 800, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "x %f y %f root x %f root y %f"
params = pos x, pos y, root, pos x, root, pos y
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
triggerall = !(root, life <= root, lifemax/4 && helper(4500), stateno = 2002)
trigger1 = numhelper(50) > 0 && Alive && ((helper(4500), stateno = 4500 || helper(4500), stateno = 200) || (helper(4500), stateno = 2002 && helper(4500), time > 32))
x = ((helper(50), pos x + (60.0 * facing)*Const(size.xscale))-pos x)*facing
y = var(0)*0.3*Const(size.yscale)
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
triggerall = !(root, life <= root, lifemax/4 && helper(4500), stateno = 2002)
trigger1 = numhelper(50) > 0 && Alive && (helper(4500), stateno = 704 || helper(4500), stateno = 201) && helper(4500), var(13) = 0
x = (((helper(50), pos x + (36.0 * facing)*Const(size.xscale))-pos x)*facing)/128
y = ((helper(50), pos y - 53*Const(size.yscale))-pos y)/128
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
triggerall = !(root, life <= root, lifemax/4 && helper(4500), stateno = 2002)
trigger1 = numhelper(50) > 0 && Alive && helper(4500), stateno = 704 && helper(4500), var(13) = 1
x = (((helper(50), pos x + (74.0 * facing)*Const(size.xscale))-pos x)*facing)/16
y = ((helper(50), pos y - 28*Const(size.yscale))-pos y)/16
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
triggerall = !(root, life <= root, lifemax/4 && helper(4500), stateno = 2002)
trigger1 = numhelper(50) > 0 && Alive && helper(4500), stateno = 2006 && helper(4500), var(0) = [1,5]
x = (((helper(50), pos x + (60.0 * facing)*Const(size.xscale))-pos x)*facing)/16
y = ((helper(50), pos y - 32*Const(size.yscale))-pos y)/16
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
triggerall = !(root, life <= root, lifemax/4 && helper(4500), stateno = 2002)
trigger1 = numhelper(50) > 0 && Alive && helper(4500), stateno = 2006 && helper(4500), var(0) >= 6
x = ((helper(50), pos x + (60.0 * facing)*Const(size.xscale))-pos x)*facing
y = var(0)*0.3*Const(size.yscale)
ignorehitpause = 1

[State 800, PosSet]
type = PosSet
trigger1 = var(1) && helper(4500), stateno != 704 && helper(4500), stateno != 2002 && !(helper(4500), stateno = 2006 && helper(4500), var(0))
x = helper(50), pos x + (36*facing)*Const(size.xscale)
y = helper(50), pos y - 53*Const(size.yscale)
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
trigger1 = helper(4500), stateno = 2002 && root, life <= root, lifemax/4
x = (((helper(50), pos x + (36*facing)*Const(size.xscale))-pos x)*facing)/32
y = ((helper(50), pos y - 53*Const(size.yscale))-pos y)/32
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
trigger1 = helper(4500), stateno = 2002 && helper(4500), time < 10
x = (((helper(50), pos x + (40.0 * facing)*Const(size.xscale))-pos x)*facing)/8
y = ((helper(50), pos y - 80*Const(size.yscale))-pos y)/8
ignorehitpause = 1

[State 800, PosSet]
type = PosAdd
trigger1 = helper(4500), stateno = 2002 && helper(4500), time >= 10 && helper(4500), time <= 32 && root, life > root, lifemax/4
x = (((helper(50), pos x + (10.0 * facing)*Const(size.xscale))-pos x)*facing)/8
y = ((helper(50), pos y - 70*Const(size.yscale))-pos y)/8
ignorehitpause = 1

[State 800, VarSet]
type = VarSet
trigger1 = root, life <= lifemax/2 && root, life >= lifemax/4 && var(1) != 1 && !helper(4500), var(54)
trigger2 = helper(4500), stateno = 2002 && root, life <= root, lifemax/4
v = 1
value = 1
ignorehitpause = 1

[State 800, VarSet]
type = VarSet
trigger1 = root, life > lifemax/2 || root, life < lifemax/4 && var(1) != 0
v = 1
value = 0
ignorehitpause = 1


[State 800, VarSet]
type = VarSet
trigger1 = !var(0)
v = 0    ;fv = 10
value = 1
ignorehitpause = 1

[State 800, VelSet]
type = VarSet
triggerall = numhelper(50) > 0
trigger1 = pos y <= helper(50), pos y - 60*Const(size.yscale)
trigger2 = EnemyNear, pos y > pos y && EnemyNear, pos y <= helper(50), pos y - 30*Const(size.yscale) && !var(1) && helper(4500), stateno != 2006
trigger3 = helper(4500), stateno = 2006 && numhelper(2001) && helper(4500), var(0) >= 6
trigger3 = helper(2001), pos y > pos y && helper(2001), pos y <= helper(50), pos y - 30*Const(size.yscale) && !var(1)
v = 0
value = 1
ignorehitpause =  1

[State 800, VelSet]
type = VarSet
triggerall = numhelper(50) > 0
trigger1 = pos y >= helper(50), pos y - 30*Const(size.yscale)
trigger2 = EnemyNear, pos y < pos y && EnemyNear, pos y >= helper(50), pos y - 60*Const(size.yscale) && !var(1) && helper(4500), stateno != 2006
trigger3 = helper(4500), stateno = 2006 && numhelper(2001) && helper(4500), var(0) >= 6
trigger3 = helper(2001), pos y < pos y && helper(2001), pos y >= helper(50), pos y - 60*Const(size.yscale) && !var(1)
v = 0
value = -1
ignorehitpause =  1

[State 800, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

[State 800, NotHitBy]
type = NotHitBy
trigger1 = time = 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1

; Parte do pescoco
[Statedef 900]
type = A
movetype = I
physics = N
anim = 41
ctrl = 0
sprpriority = -4

[State 4000, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && helper(4500), var(54) && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 4000, AssertSpecial]
type = AssertSpecial
triggerall = numhelper(60)
trigger1 = helper(60), Pos Y > 0
flag = noshadow

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

;Posicionar primeira parte do pescoco
[State 900, PosSet]
type = PosSet
trigger1 = numhelper(50) > 0 && IsHelper(10)
x = (helper(11), pos x+((helper(50), pos x + (25.0*facing)*Const(size.xscale))))/2
y = (helper(11), pos y+(helper(50), pos y - 45*Const(size.yscale)))/2
ignorehitpause = 1

;Posicionar segunda parte do pescoco
[State 900, PosSet]
type = PosSet
trigger1 = numhelper(50) > 0 && IsHelper(11)
x = (helper(12), pos x+((helper(10), pos x)))/2
y = (helper(12), pos y+(helper(10), pos y))/2
ignorehitpause = 1

;Posicionar terceira parte do pescoco
[State 900, PosSet]
type = PosSet
trigger1 = numhelper(50) > 0 && IsHelper(12)
x = (helper(13), pos x+((helper(11), pos x)))/2
y = (helper(13), pos y+(helper(11), pos y))/2
ignorehitpause = 1

;Posicionar quarta parte do pescoco
[State 900, PosSet]
type = PosSet
trigger1 = numhelper(50) > 0 && IsHelper(13)
x = (root, pos x+((helper(12), pos x)))/2
y = (root, pos y+(helper(12), pos y))/2
ignorehitpause = 1

[State 900, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

[State 900, NotHitBy]
type = NotHitBy
trigger1 = time = 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1

[State 900, DestroySelf]
type = DestroySelf
trigger1 = numhelper(50) <= 0

; Plataforma
[Statedef 1000]
type = S
movetype = I
physics = S
anim = 1000
ctrl = 0

[State 1000, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

;[State 1000, PosFreeze]
;type = PosSet
;trigger1 = 1
;;x = parent, pos x
;y = 0
;ignorehitpause = 1

;[State 1000, PlayerPush]
;type = PlayerPush
;;trigger1 = 1
;value = 1
;ignorehitpause = 1

[State 1000, Helper]
type = Helper
trigger1 = time = 0 && numhelper(1003) <= 0
helpertype = normal
name = "Rinka Turret"
ID = 1003
stateno = 1003
pos = floor(pos x*Const(size.xscale)),floor(pos y*Const(size.yscale))
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
size.ground.back = 7
size.ground.front = 7
size.air.back = 7
size.air.front = 7
size.height = 14
ignorehitpause = 1

[State 1000, Helper]
type = Helper
trigger1 = time = 0 && numhelper(1040) <= 0
helpertype = normal
name = "Rinka Turret"
ID = 1040
stateno = 1003
pos = floor(pos x*Const(size.xscale)),floor(pos y*Const(size.yscale))
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
size.ground.back = 7
size.ground.front = 7
size.air.back = 7
size.air.front = 7
size.height = 14
ignorehitpause = 1

[State 1000, VarSet]
type = VarSet
trigger1 = time = 0
fv = 0
value =  pos x
ignorehitpause = 1

[State 1000, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1000
time = 1
forceair = 0
ignorehitpause = 1

;[State 1000, NotHitBy]
;type = NotHitBy
;trigger1 = 1
;value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
;time = 1
;ignorehitpause = 1

[State 1000, SprPriority]
type = SprPriority
trigger1 = 1
value = -2
ignorehitpause = 1

[State 1000, VarAdd]
type = VarAdd
trigger1 = !root, Alive
v = 10
value = 1
ignorehitpause = 1

[State 1000, PlaySnd]
type = PlaySnd
trigger1 = !root, Alive && time % 11 = 0
value = S100,0
channel = 3
ignorehitpause = 1

[State 1000, EnvColor]
type = EnvColor
trigger1 = !root, Alive && time % 8 = 0
value = 255,255,255
time = 1
under = 1
ignorehitpause = 1

[State 1000, EnvShake]
type = EnvShake
trigger1 = !root, Alive && time % 10 = 0
time = 10
freq = 60
ampl = -4
phase = 90
ignorehitpause = 1

[State 1000, Explod]
type = Explod
trigger1 = !root, Alive
anim = ifelse(random <= 500, 2, 63)
ID = 2
pos = 0,-80
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 96,177
removetime = -2
sprpriority = 0
ownpal = 1
ignorehitpause = 1

[State 1000, DestroySelf]
type = DestroySelf
trigger1 =  var(10) >= 300
ignorehitpause = 1

; Vidro
[Statedef 1001]
type = S
movetype = I
physics = S
ctrl = 0
sprpriority = 0

[State 1001, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 1
ignorehitpause = 1

[State 1001, PosSet]
type = PosSet
trigger1 = 1
x = (helper(1000), pos x+(1*facing)*Const(size.xscale))
y = (helper(1000), pos y-71*Const(size.yscale))
ignorehitpause = 1

[State 1001, ChangeAnim]
type = ChangeAnim
trigger1 = fvar(0) <= 9
value = 1001 + floor(fvar(0))
ignorehitpause = 1

[State 1001, PlaySnd]
type = PlaySnd
trigger1 = var(0) != anim && var(0) != 0 || fvar(0) > 9
value = S50,0
channel = -1
ignorehitpause = 1

[State 1001, Explod]
type = Explod
trigger1 = var(0) != anim && var(0) != 0 && (anim = 1004 || anim = 1007 || fvar(0) > 9)
anim = 1013
ID = 1013
pos = ifelse(anim = 1004,24,ifelse(anim = 1007,-27,0)), ifelse(anim = 1004,-31,ifelse(anim = 1007,-29,0))
postype = p1  ;p2,front,back,left,right
bindtime = 1
vel = random/1000,-1-random/200
accel = 0, 0.2
random = 5,5
removetime = 120
scale = Const(size.xscale), Const(size.yscale)
ownpal = 1
sprpriority = 2
ignorehitpause = 1

[State 1001, Explod]
type = Explod
trigger1 = var(0) != anim && var(0) != 0 && (anim = 1004 || anim = 1007 || fvar(0) > 9)
anim = 1013
ID = 1013
pos = ifelse(anim = 1004,24,ifelse(anim = 1007,-27,0)), ifelse(anim = 1004,-31,ifelse(anim = 1007,-29,0))
postype = p1  ;p2,front,back,left,right
bindtime = 1
vel = random/1000,-1-random/200
accel = 0, 0.2
random = 5,5
removetime = 120
scale = Const(size.xscale), Const(size.yscale)
ownpal = 1
sprpriority = 2
ignorehitpause = 1

[State 1001, Explod]
type = Explod
trigger1 = var(0) != anim && var(0) != 0 && (anim = 1004 || anim = 1007 || fvar(0) > 9)
anim = 1013
ID = 1013
pos = ifelse(anim = 1004,24,ifelse(anim = 1007,-27,0)), ifelse(anim = 1004,-31,ifelse(anim = 1007,-29,0))
postype = p1  ;p2,front,back,left,right
bindtime = 1
vel = random/1000,-1-random/200
accel = 0, 0.2
random = 5,5
removetime = 120
scale = Const(size.xscale), Const(size.yscale)
ownpal = 1
sprpriority = 2
ignorehitpause = 1

[State 1002, VarAdd]
type = VarAdd
trigger1 = root, stateno = 200 && root, var(11) && root, time <= 1
fv = 0
value = (root, var(11)/1000.0)*9
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
trigger1 = var(0) != anim
v = 0    ;fv = 10
value = anim
ignorehitpause = 1

[State 1001, DestroySelf]
type = DestroySelf
trigger1 = fvar(0) > 9 || !root, alive
ignorehitpause = 1

[State 1001, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1002
time = 1
forceair = 0
ignorehitpause = 1

[State 1001, VarSet]
type = VarSet
trigger1 = !root, var(4) && Var(4)
v = 4
value = 0
ignorehitpause = 1

[State 1001, ChangeState]
type = ChangeState
trigger1 = root, var(4) && !var(4)
value = 1002
ctrl = 0

[Statedef 1002]
type = S
movetype = H
physics = S
ctrl = 0
velset = 0, 0

[State 1002, VarAdd]
type = VarAdd
trigger1 = time = 0
fv = 0
value = (GetHitVar(damage)/1000.0)*9
ignorehitpause = 1

[State 1002, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "damage %f"
params = fvar(0)
ignorehitpause = 1

[State 1002, VarSet]
type = VarSet
trigger1 = time = 0 && root, var(4)
v = 4
value = 1
ignorehitpause = 1

[State 1002, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1002
time = 1
forceair = 0
ignorehitpause = 1

[State 1002, ChangeState]
type = ChangeState
trigger1 = 1
value = 1001
ctrl = 0
ignorehitpause = 1

; Rinka Turret
[Statedef 1003]
type = S
movetype = I
physics = S
ctrl = 0
velset = 0, 0
anim = 1010

[State 1003, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
ignorehitpause = 1

[State 1003, PosSet]
type = BindToParent
trigger1 = 1
time = 5
pos = 1, ifelse(IsHelper(1003), -47, -159)*Const(size.yscale)
ignorehitpause = 1

[State 1003, VelSet]
type = VelSet
trigger1 = 1
x = parent, vel x
y = parent, vel y
ignorehitpause = 1

[State 1003, SprPriority]
type = SprPriority
trigger1 = 1
value = -1
ignorehitpause = 1

; Bia's Code
[State 1003, Componente X]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
Trigger1 = time % 100 = 0 && roundstate = 2
fvar(13) = (EnemyNear(ifelse(enemynear(0), alive, 0, 1)), Pos X+(EnemyNear(ifelse(enemynear(0),alive,0,1)),Const(size.mid.pos.x)*EnemyNear(ifelse(enemynear(0),alive,0,1)),facing)- Pos X) * Facing ;Ajusta a direção da componente por facing

[State 1003, Componente Y]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
trigger1 = time % 100 = 0 && roundstate = 2
fvar(14) = (EnemyNear(ifelse(enemynear(0), alive, 0, 1)), pos Y+EnemyNear(ifelse(enemynear(0),alive,0,1)),Const(size.mid.pos.y) - Pos Y)

[State 1003, Normal]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
trigger1 = time % 100 = 0 && roundstate = 2
fvar(15) = Exp(0.5*ln((fvar(13) * fvar(13))+(fvar(14) * fvar(14))))

[State 1003, Helper]
type = Helper
trigger1 = time % 100 = 0 && roundstate = 2 && numhelper(1004) < 3
helpertype = normal
name = "Rinka"
ID = 1004
stateno = 1004
pos = 0,0
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State 1003, PalFXWiz]
type = PalFX
trigger1 = time % 150 = 0
time = 150
add = 0,0,0
mul = 256,256,256
sinadd = -30,-30,-30,150
invertall = 0
color = 256
ignorehitpause = 1

[State 1003, DestroySelf]
type = DestroySelf
trigger1 = !root, Alive
ignorehitpause = 1

; Rinka
[Statedef 1004]
type = A
physics = N
ctrl = 0
anim = 1011
velset = 0,0

[State 1004, VarSet]
type = VarSet
trigger1 = time = 0
fv = 10
value = parent, Fvar(13)
ignorehitpause = 1

[State 1004, VarSet]
type = VarSet
trigger1 = time = 0
fv = 11
value = parent, Fvar(14)
ignorehitpause = 1

[State 1004, VarSet]
type = VarSet
trigger1 = time = 0
fv = 12
value = parent, Fvar(15)
ignorehitpause = 1

[State 1004, VelSet]
type = VelSet
trigger1 = time = 50 && fvar(12) != 0
x = (Fvar(10)/fvar(12)) * 1.0
y = (FVar(11)/fvar(12)) * 1.0
ignorehitpause = 1

[State 1004, StateTypeSet]
type = StateTypeSet
trigger1 = abs(enemynear, Pos X - Pos X) <= 20
movetype = A
ignorehitpause = 1

[State 1004, HitDef]
type = HitDef
trigger1 = 1;abs(enemynear, Pos X - Pos X) <= 20 && abs(enemynear, Pos Y - Pos Y) <= 100
attr = A,NP        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAFD
guardflag = A;MA         ;HLA
getpower = 20,0
givepower = 40,0
animtype = medium          ;light,medium,hard,back,up,diagup
air.animtype = medium
priority = 4,Miss   ;Hit,Miss,Dodge
damage = 50,0
pausetime = 0,25
sparkno = -1
guard.sparkno = -1
hitsound = 0,0
guardsound = 0,0
ground.type = High      ;Low,Trip,None
ground.slide = 0
ground.hit = 0
air.hittime = 20
ground.velocity = -1,-4
air.velocity = -1,-4
guard.dist = 0
fall = 0
fall.yvelocity = -4.5
fall.recover = 1
fall.recovertime = 4
fall.damage = 0
down.bounce = 0
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 1
palfx.time = 25
palfx.add = 256,256,256
ignorehitpause = 1

[State 1004, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noautoturn
flag2 = unguardable
ignorehitpause = 1

[State 1004, PalFXWiz]
type = PalFX
trigger1 = time % 60 = 0
time = 60
add = 0,0,0
mul = 256,256,256
sinadd = 30,30,30,60
ignorehitpause = 1

[State 1004, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 1005
time = 1
ignorehitpause = 1

[State 1004, DestroySelf]
type = ChangeState
trigger1 = time > 600 || movecontact || Pos Y >= 0 || roundstate != 2
value = 1005
ignorehitpause = 1

; Rinka Destroyed
[Statedef 1005]
type = A
movetype = H
physics = N
ctrl = 0
anim = 1011

[State 1005, PlaySnd]
type = PlaySnd
trigger1 = time = 0
value = S100,0
volume = 0
channel = -1
ignorehitpause = 1

[State 1005, Explod]
type = Explod
trigger1 = time = 0
anim = 2
ID = 2
pos = 0,0
bindtime = 1
removetime = -2
scale = Const(size.xscale), Const(size.yscale)
sprpriority = 4
shadow = 0,0,0
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State 1005, DestroySelf]
type = DestroySelf
trigger1 = 1
ignorehitpause = 1

; Ácido
[Statedef 1006]
type = S
physics = N
ctrl = 0
anim = 1012
sprpriority = 5

[State 1006, SprPriority]
type = SprPriority
trigger1 = 1
value = 5
ignorehitpause = 1

[State 1006, VelSet]
type = VelSet
trigger1 = roundstate = 2
x = 0
y = ifelse(Pos Y > -25*root, Const(size.yscale), -0.1*root, Const(size.yscale), 0)
ignorehitpause = 1

[State 1006, PlaySnd]
type = PlaySnd
trigger1 = roundstate = 2 && Pos Y > -25 && time % 11 = 0
value = S100,0
channel = 3
ignorehitpause = 1

[State 1006, VelSet]
type = VelSet
trigger1 = Lose
x = 0
y = ifelse(Pos Y < 200*root, Const(size.yscale), 0.2, 0)
ignorehitpause = 1

[State 1006, EnvShake]
type = EnvShake
trigger1 = Pos Y > -25 && roundstate = 2 && time % 60 = 0
time = 60
freq = 60
ampl = -4
phase = 90
ignorehitpause = 1

[State 1006, VarSet]
type = VarSet
trigger1 = time = 0
v = 10    ;fv = 10
value = 128
ignorehitpause = 1

[State 1006, VarAdd]
type = VarAdd
trigger1 = Win && var(0) > 0
v = 10
value = -1
ignorehitpause = 1

[State 1006, Trans]
type = Trans
trigger1 = 1
trans = addalpha
alpha = 256, var(10)
ignorehitpause = 1

[State 1006, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = noshadow
flag2 = unguardable
flag3 = noautoturn
ignorehitpause = 1

[State 1006, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "%d"
params = facing
ignorehitpause = 1

[State 1006, PosSet]
type = PosSet
trigger1 = 1
x = floor(-320*Const(size.xscale))
ignorehitpause = 1

[State 1006, PlaySnd]
type = PlaySnd
trigger1 = !var(0) && enemynear, Pos Y >= Pos Y
value = S150,0
channel = 2
loop = 1
ignorehitpause = 1

[State 1006, StopSnd]
type = StopSnd
trigger1 = enemynear, Pos Y < Pos Y
channel = 2
ignorehitpause = 1

[State 1006, VarSet]
type = VarSet
trigger1 = enemynear, Pos Y >= Pos Y
v = 0
value = 1
ignorehitpause = 1

[State 1006, VarSet]
type = VarSet
trigger1 = enemynear, Pos Y < Pos Y
v = 0
value = 0
ignorehitpause = 1

[State 1006, StateTypeSet]
type = StateTypeSet
triggerall = var(5) <= time && roundstate = 2
trigger1 = NumEnemy = 1
trigger1 = enemy(0), Pos Y >= Pos Y
trigger2 = NumEnemy = 2
trigger2 = enemy(1), Pos Y >= Pos Y
movetype = A
ignorehitpause = 1

[State 1006, HitDef]
type = HitDef
triggerall = var(5) < time && roundstate = 2
trigger1 = 1
;trigger1 = NumEnemy = 1
;trigger1 = enemy(0), Pos Y >= Pos Y
;trigger2 = NumEnemy = 2
;trigger2 = enemy(1), Pos Y >= Pos Y
attr = S,NA
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
getpower = 0,0
givepower = 60,0
damage = 25, 1
pausetime = 0, 0
animtype = light          ;light,medium,hard,back,up,diagup
priority = 4,Miss   ;Hit,Miss,Dodge
sparkno = -1
guard.sparkno = -1
guard.dist = 0
sparkxy = -1
hitsound = 0,0
guardsound = 0,0
ground.type = Low
ground.hittime = 0
ground.slidetime = 0

[State 1006, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "Next hit = %d"
params = var(5)
ignorehitpause = 1

[State 1006, VarSet]
type = VarSet
trigger1 = movecontact
v = 5
value = time + 60
ignorehitpause = 1

[State 1006, MoveHitReset]
type = MoveHitReset
trigger1 = movecontact
ignorehitpause = 1

; Bomb
[Statedef 1007]
type = A
movetype = I
physics = N
anim = 62
ctrl = 0
sprpriority = -2

[State 1007, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 1007, AfterImage]
type = AfterImage
trigger1 = time = 0
time = 2
length = 20
palcolor = 256
palbright = 64,0,128
palcontrast = 120,0,220
ignorehitpause = 1

[State 1007, AfterImageTime]
type = AfterImageTime
trigger1 = anim = 62
time = 2
ignorehitpause = 1

[State 1007, Explod]
type = Explod
trigger1 = time < 70 && !(time % 10)
anim = 7
ID = 7
pos = 0,floor(-6*Const(size.yscale))
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
removetime = -2
sprpriority = 3
shadow = -1,-1,-1
ownpal = 1
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
trigger1 = abs(vel y) > .05 || time <= 40
x = 0.5*Const(size.xscale)
ignorehitpause = 1

[State 1007, VelAdd]
type = VelAdd
trigger1 = Pos Y < 0 && time > 25
y = .05*Const(size.yscale)
ignorehitpause = 1

[State 1007, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "pos x %f vel x %f facing %d"
params = pos x, vel x, facing
ignorehitpause = 1

[State 1007, VelSet]
type = Turn
trigger1 = pos x <= -(320/2) && facing = -1
ignorehitpause = 1

[State 1007, VelSet]
type = Turn
trigger1 = FrontEdgeBodyDist <= 0;pos x >= (320/2) && facing = 1
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
trigger1 = Pos Y >= 0 && abs(vel y) > .05*Const(size.yscale)
y = -abs(vel y)/1.5
ignorehitpause = 1

[State 1007, VelSet]
type = VarSet
trigger1 = Pos Y >= 0 && abs(vel y) <= .05*Const(size.yscale) && !var(0)
v = 0
value = time
ignorehitpause = 1

[State 1007, VelSet]
type = VelSet
trigger1 = var(0)
x = 0
y = 0
ignorehitpause = 1

[State 1007, ChangeAnim]
type = ChangeAnim
trigger1 = var(0) && anim != 2 && anim != 550
value = 2
ignorehitpause = 1

[State 1007, PlaySnd]
type = PlaySnd
trigger1 = anim = 2 && animelem = 1
trigger2 = var(0) && (time = var(0) || time % 10 = 0)
value = S100,0
ignorehitpause = 1

[State 1007, PosSet]
type = PosSet
trigger1 = anim = 2
y = Pos Y - 7*Const(size.yscale)
ignorehitpause = 1
persistent = 0

[State 1007, PosSet]
type = SprPriority
trigger1 = anim = 2
value = 4
ignorehitpause = 1

[State 1007, AssertSpecial]
type = ChangeAnim
trigger1 = anim = 2 && animtime = 0
value = 550
ignorehitpause = 1

[State 1007, AssertSpecial]
type = AssertSpecial
trigger1 = anim = 550
flag = invisible
ignorehitpause = 1

[State 1007, Projectile]
type = Projectile
trigger1 = var(0) && (time = var(0) || time % 10 = 0)
ProjID = 1007
projanim = 63
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = Const(size.xscale),Const(size.yscale)
projremove = 0
projremovetime = 40
velocity = 0,0
remvelocity = 0,0
accel = 0,0
velmul = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -240
offset = floor((var(0)-time)*Const(size.xscale)),floor(7*Const(size.yscale))
postype = p1         ;p2,front,back,left,right
projshadow = -1,-1,-1
; HitDef
attr = S,SA        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAFD        ;HLAFD+-
guardflag = L         ;HLA
getpower = 10,0
givepower = 10,0
;affectteam = E          ;B,E,F
animtype = light          ;light,medium,hard,back,up,diagup
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 15,0
pausetime = 15,0
guard.dist = 0
sparkno = 0
guard.sparkno = 0
sparkxy = 0,0
hitsound = 0,0
guardsound = 0,0
ground.type = Low      ;Low,Trip,None
ground.velocity = -15, -5
fall = ifelse(!helper(4500), var(54), 1, 0)
ignorehitpause = 1

[State 1007, Projectile]
type = Projectile
trigger1 = var(0) && (time > var(0) && time % 10 = 0)
ProjID = 1007
projanim = 63
projhitanim = -1
projremanim = -1
projcancelanim = -1
projscale = Const(size.xscale),Const(size.yscale)
projremove = 0
projremovetime = 40
velocity = 0,0
remvelocity = 0,0
accel = 0,0
velmul = 1
projhits = 1
projmiss = 0
projpriority = 1
projsprpriority = 3
projedgebound = 40
projstagebound = 40
projheightbound = -240
offset = floor(-(var(0)-time)*Const(size.xscale)),floor(7*Const(size.yscale))
postype = p1         ;p2,front,back,left,right
projshadow = -1,-1,-1
; HitDef
attr = S,SA        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAFD        ;HLAFD+-
guardflag = L         ;HLA
getpower = 10,0
givepower = 10,0
;affectteam = E          ;B,E,F
animtype = light          ;light,medium,hard,back,up,diagup
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 15,0
pausetime = 15,0
guard.dist = 0
sparkno = 0
guard.sparkno = 0
sparkxy = 0,0
hitsound = 0,0
guardsound = 0,0
ground.type = Low      ;Low,Trip,None
ground.velocity = -15, -5
fall = ifelse(!helper(4500), var(54), 1, 0)
ignorehitpause = 1

[State 1007, DestroySelf]
type = DestroySelf
trigger1 = var(0) && time - var(0) > 80
ignorehitpause = 1

; Supernova Beam
[Statedef 1008]
type = A
movetype = A
physics = N
anim = 64
ctrl = 0
sprpriority = -2

; Bia's Code
[State 1003, Componente X]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
Trigger1 = time = 0 && roundstate = 2
fvar(13) = (EnemyNear(ifelse(enemynear(0), alive, 0, 1)), Pos X+(EnemyNear(ifelse(enemynear(0),alive,0,1)),Const(size.mid.pos.x)*EnemyNear(ifelse(enemynear(0),alive,0,1)),facing)- Pos X) * Facing ;Ajusta a direção da componente por facing

[State 1003, Componente Y]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
trigger1 = time = 0 && roundstate = 2
fvar(14) = (EnemyNear(ifelse(enemynear(0), alive, 0, 1)), pos Y+EnemyNear(ifelse(enemynear(0),alive,0,1)),Const(size.mid.pos.y) - Pos Y)

[State 1003, Normal]
Type = VarSet
triggerall = numenemy > 0 && numenemy <= 2
triggerall = !(!enemynear(0), alive && numenemy = 1)
trigger1 = time = 0 && roundstate = 2
fvar(15) = Exp(0.5*ln((fvar(13) * fvar(13))+(fvar(14) * fvar(14))))

[State 1008, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = unguardable
ignorehitpause = 1

[State 1008, AssertSpecial]
type = AssertSpecial
trigger1 = !var(0)
flag = invisible
ignorehitpause = 1

[State 1008, VelSet]
type = VelSet
trigger1 = time = 0
x = (fvar(13)/fvar(15))*5*Const(size.xscale)
y = (fvar(14)/fvar(15))*5*Const(size.yscale)
ignorehitpause = 1

[State 1008, StateTypeSet]
type = StateTypeSet
trigger1 = var(0)
movetype = I
ignorehitpause = 1

[State 1008, Explod]
type = Explod
trigger1 = time % 3 = 0 && !var(0)
anim = 64
ID = 64
pos = 0,0
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = floor(10),floor(10)
removetime = 50
sprpriority = 0
ontop = 0
shadow = -1,-1,-1
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State 1008, HitDef]
type = HitDef
trigger1 = !var(0)
attr = S,NA        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MLAD        ;HLAFD+-
guardflag = L         ;HLA
getpower = 100,0
givepower = 20,0
animtype = Hard          ;light,medium,hard,back,up,diagup
air.animtype = Hard
priority = 4,Hit   ;Hit,Miss,Dodge
damage = 200,0
pausetime = 0,75
guard.dist = 0
sparkno = S8
hitsound = S100,0
guardsound = 0,0
ground.type = Trip      ;Low,Trip,None
ground.velocity = 10,0
p1getp2facing = 1
fall = 1

[State 1007, VelSet]
type = VelSet
trigger1 = FrontEdgeBodyDist <= 0 || (ScreenPos Y <= 0 && vel y < 0) || (Pos Y >= 0 && vel y > 0) || movehit
x = 0
y = 0
ignorehitpause = 1

[State 1007, VarSet]
type = VarSet
trigger1 = abs(vel x + vel y) <= 0.2 && !var(0)
v = 0
value = time
ignorehitpause = 1

;[State 1007, VarAdd]
;type = VarAdd
;trigger1 = var(0)
;v = 1
;value = 1

[State 1007, ChangeAnim]
type = ChangeAnim
trigger1 = anim != 16 && var(0)
value = 16

[State 1007, AngleDraw]
type = AngleDraw
trigger1 = var(0)
scale = 0.5*((time-var(0))/60.0),0.5*((time-var(0))/60.0)
ignorehitpause = 1

[State 1007, Trans]
type = Trans
trigger1 = var(0)
trans = addalpha
alpha = floor(255-(255.0*((time-var(0))/60.0))), floor((255.0*((time-var(0))/60.0)))
ignorehitpause = 1

[State 1007, VelSet]
type = Explod
trigger1 = var(0) && time % 6 = 0
anim = ifelse(random <= 500, 2, ifelse(random <= 700, 63, 8))
ID = 8
pos = 0,0
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = floor(15),floor(15)
removetime = -2
shadow = -1,-1,-1
ownpal = 1
removeongethit = 0
ontop = 1

[State 1007, AllPalFX]
type = AllPalFX
trigger1 = var(0) && time - var(0) <= 60
time = 1
add = 256-floor(((time - var(0))/60.0)*256.0),256-floor(((time - var(0))/60.0)*256.0),256-floor(((time - var(0))/60.0)*256.0)
mul = 256,256,256
ignorehitpause = 1

[State 1007, EnvShake]
type = EnvShake
trigger1 = var(0)
time = 75
freq = 120
ampl = -10
phase = 90
persistent = 0
ignorehitpause = 1

[State 1007, PlaySnd]
type = PlaySnd
trigger1 = var(0) && !(time % 15)
value = S100,0

[State 1008, DestroySelf]
type = DestroySelf
trigger1 = var(0) && time - var(0) > 60
ignorehitpause = 1
;(pos x <= -(320/2) && facing = -1) || (pos x >= (320/2) && facing = 1)

; Contorno
[Statedef 2000]
type = S
movetype = I
physics = N
anim = 1
ctrl = 0
sprpriority = -1

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

[State 2000, BindToRoot]
type = BindToRoot
trigger1 = time = 0
time = -1
facing = 1
pos = 0,0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

[State 2000, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1
persistent = 2

[State 2000, ChangeAnim]
type = ChangeAnim
trigger1 = helper(4500), anim = 15 && anim != 14
value = 14
ignorehitpause = 1

[State 2000, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

; METROID!
[Statedef 2001]
type = A
movetype = A
physics = N
anim = 2000
ctrl = 0
sprpriority = 5

[State 0, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = timerfreeze
flag2 = unguardable

[State 2001, SprPriority]
type = SprPriority
trigger1 = 1
value = 5
ignorehitpause = 1

[State 2001, Helper]
type = Helper
trigger1 = !numhelper(2003)
helpertype = normal ;player
name = "Metroid Brain"
ID = 2003
stateno = 2003
pos = 0,0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1

[State 2001, VelAdd]
type = VelSet
trigger1 = time = 0
y = 10*Const(size.yscale)
ignorehitpause = 1

[State 2001, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA
time = 1
ignorehitpause = 1

[State 2001, VelAdd]
type = VelAdd
trigger1 = !var(0)
x = (ifelse(root, pos x < pos x, -1, ifelse(root, pos x > pos x, 1, 0))*facing)*Const(size.xscale)
y = (ifelse(root, pos y-26*root,Const(size.yscale) < pos y, -1, ifelse(root, pos y-26*root,Const(size.yscale) > pos y, 1, 0)))*Const(size.yscale)
ignorehitpause = 1

[State 2001, VelAdd]
type = VelSet
trigger1 = var(0) = 1
x = 0
y = 0
ignorehitpause = 1

[State 2001, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 2000 && var(0) = 1
value = 2001

[State 2001, VelAdd]
type = VelSet
trigger1 = 1
x = ifelse(vel x > 10*Const(size.xscale), 10*Const(size.xscale), ifelse(vel x < -10*Const(size.xscale), -10*Const(size.xscale), vel x))
y = ifelse(vel y > 10*Const(size.yscale), 10*Const(size.yscale), ifelse(vel y < -10*Const(size.yscale), -10*Const(size.yscale), vel y))
ignorehitpause = 1

[State 2001, HitDef]
type = HitDef
trigger1 = !var(0) && helper(4500), stateno != 2002
attr = A,NT        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
affectteam = F
animtype = light          ;light,medium,hard,back,up,diagup
air.animtype = light
priority = 8,Hit   ;Hit,Miss,Dodge
sparkno = -1
id = 2001
guard.sparkno = -1
sparkxy = 0,0
kill = 1
guard.kill = 1
fall.kill = 1
numhits = 0

[State 2001, TargetLifeAdd]
type = TargetLifeAdd
trigger1 = movehit && !var(0) && numtarget
trigger1 = target(2001), id = root, id
value = target, lifemax
absolute = 1
ignorehitpause = 1
persistent = 0

[State 2001, VarAdd]
type = VarSet
trigger1 = !var(0) && movehit && numtarget
trigger1 = target(2001), id = root, id
v = 0
value = 1
ignorehitpause = 1

[State 2001, AssertSpecial]
type = AssertSpecial
trigger1 = var(0)
flag = nobardisplay
ignorehitpause = 1

[State 2001, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(0) = %d rootdist Y %f var(7) %d var(9) %d"
params = var(0), rootdist Y, var(7), var(9)
ignorehitpause = 1

[State 2001, PosSet]
type = PosSet
trigger1 = var(0) = 1
x = root, pos x + ((3 - random % 5)*root,facing)*Const(size.xscale)
y = root, pos y - (29 - random % 5)*Const(size.yscale)
ignorehitpause = 1

[State 2001, VarAdd]
type = VarSet
trigger1 = var(0) = 1 && root, life <= 1
v = 0
value = 2
ignorehitpause = 1

[State 2001, ChangeAnim]
type = ChangeAnim
trigger1 = var(0) = 2 && anim = 2001
value = 2006

[State 2001, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 2006 && animtime = 0
value = 2004

[State 2001, VelSet]
type = VelAdd
trigger1 = anim = 2004
y = ifelse(vel y > -2*Const(size.yscale), -0.1*Const(size.yscale), 0)

[State 2001, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 2004 && animtime = 0
value = 2005

[State 2001, VelSet]
type = VelAdd
trigger1 = anim = 2005 && !var(7)
x = ifelse(vel x > 0, ifelse(vel x > 0.1, -0.1, -vel x), ifelse(vel x < 0, ifelse(vel x < 0.1, 0.1, vel x), 0))
y = ifelse(vel y > 0, ifelse(vel y > 0.1, -0.1, -vel y), ifelse(vel y < 0, ifelse(vel y < 0.1, 0.1, vel y), 0))

[State 2001, PlaySnd]
type = PlaySnd
trigger1 = anim = 2005 && !var(7)
value = S2001,0
ignorehitpause = 1
persistent = 0

[State 2001, VarAdd]
type = VarAdd
trigger1 = !var(7) && rootdist y > 40*Const(size.yscale) && !vel x && !vel y
v = 7
value = 1
ignorehitpause = 1

[State 2001, VarAdd]
type = VarSet
trigger1 = var(7)
v = 8
value = ifelse(enemynear(0), alive, 0, 1)
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
trigger1 = var(52) != var(7)
v = 9
value = gametime
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
trigger1 = var(52) != var(7)
v = 52
value = var(7)
ignorehitpause = 1

[State 2001, VarAdd]
type = VarSet
trigger1 = var(7) = 3 && gametime - var(9) > 120
v = 7
value = 4
ignorehitpause = 1

[State 2001, VarAdd]
type = VarSet
trigger1 = var(7) = 2 && gametime - var(9) > 180
v = 7
value = 3
ignorehitpause = 1

[State 2001, VarAdd]
type = VarSet
trigger1 = var(7) = 1 && gametime - var(9) > 70
v = 7
value = 2
ignorehitpause = 1

;[State 2001, HitDef]
;type = HitDef
;trigger1 = var(7) = 4
;attr = A,NT        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
;hitflag = MAF        ;HLAFD+-
;guardflag = MA         ;HLA
;affectteam = E
;animtype = light          ;light,medium,hard,back,up,diagup
;air.animtype = light
;priority = 8,Hit   ;Hit,Miss,Dodge
;sparkno = -1
;id = 2002
;guard.sparkno = -1
;sparkxy = 0,0
;kill = 1
;p2stateno = 2005
;guard.kill = 1
;fall.kill = 1
;numhits = 0

[State 2001, TargetDrop]
type = TargetDrop
triggerall = var(7) = 4 && numtarget
trigger1 = target, id = root, id
ignorehitpause = 1

[State 2001, VarAdd]
type = ChangeState
triggerall = numhelper(2003) && var(7) = 4 && numenemy
trigger1 = helper(2003), movehit && helper(2003), numtarget
;trigger1 = target(2002),id = enemynear(var(8)),id
value = 2004

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 1 && enemynear(var(8)), alive
v = 11
value = floor(root, pos x-(150*root, facing)*Const(size.xscale))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 1 && enemynear(var(8)), alive
v = 12
value = floor(root, pos y-100*Const(size.yscale))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 2 && enemynear(var(8)), alive
v = 11
value = floor(enemynear(var(8)), pos x+(150*root, facing)*Const(size.xscale))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 2 && enemynear(var(8)), alive
v = 12
value = floor(enemynear(var(8)), pos y-100*Const(size.yscale))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 3 && enemynear(var(8)), alive
v = 11
value = floor(enemynear(var(8)), pos x+enemynear(var(8)),Const(size.mid.pos.x))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 3 && enemynear(var(8)), alive
v = 12
value = floor(enemynear(var(8)), pos y+enemynear(var(8)),Const(size.mid.pos.y)-80*Const(size.yscale))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 4 && enemynear(var(8)), alive
v = 11
value = floor(enemynear(var(8)), pos x+enemynear(var(8)),Const(size.mid.pos.x))
ignorehitpause = 1

[State 2001, VarSet]
type = VarSet
triggerall = numenemy
trigger1 = var(7) = 4 && enemynear(var(8)), alive
v = 12
value = floor(enemynear(var(8)), pos y+enemynear(var(8)),Const(size.mid.pos.y))
ignorehitpause = 1

[State 2001, VelAdd]
type = VelAdd
trigger1 = var(7)
x = ((var(11) - pos x)/256)*facing
y = (var(12) - pos y)/256
ignorehitpause = 1

[State 2001, VelSet]
type = VelSet
trigger1 = var(7)
x = ifelse(vel x > 2*Const(size.xscale), 2.0*Const(size.xscale), ifelse(vel x < -2*Const(size.xscale), -2.0*Const(size.xscale), vel x))
y = ifelse(vel y > 2*Const(size.yscale), 2.0*Const(size.yscale), ifelse(vel y < -2*Const(size.yscale), -2.0*Const(size.yscale), vel y))

; MOTHER BRAIN GETTING PWNED
[Statedef 2002]
type = S
movetype = H
physics = N
ctrl = 0

;Generated by Fighter Factory PalFX Editor
[State 4500, PalFXWiz]
type = PalFX
trigger1 = root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 2002, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2002, LifeSet]
type = LifeSet
trigger1 = time = 0
value = lifemax
ignorehitpause = 1

[State 2002, VarSet]
type = VarSet
trigger1 = time = 0
v = 40
value = 255
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 41
value = 0
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 42
value = 0
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = time = 0
v = 43
value = 0
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
triggerall = life >= lifemax/2
trigger1 = var(43) = 0 && var(40) >= 255 && var(42) <= 0
trigger2 = var(43) = 1 && var(41) >= 255 && var(40) >= 255
trigger3 = var(43) = 2 && var(41) >= 255 && var(40) <= 0
trigger4 = var(43) = 3 && var(42) >= 255 && var(41) >= 255
trigger5 = var(43) = 4 && var(42) >= 255 && var(41) <= 0
trigger6 = var(43) = 5 && var(42) >= 255 && var(40) >= 255
v = 43
value = 1
ignorehitpause = 1

[State 705, PalFX]
type = PalFX
trigger1 = life >= lifemax/2
time = 1
add = 128-var(40),128-var(41),128-var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
trigger1 = life >= lifemax/2
v = 40+ifelse(var(43) = 1, 1, ifelse(var(43) = 3, 2, ifelse(var(43) = 5, 0, 6)))
value = 20
ignorehitpause = 1

[State 705, VarAdd]
type = VarAdd
trigger1 = life >= lifemax/2
v = 40+ifelse(var(43) = 0, 2, ifelse(var(43) = 2, 0, ifelse(var(43) = 4, 1, 6)))
value = -20
ignorehitpause = 1

[State 705, VarSet]
type = VarSet
trigger1 = var(43) >= 6
v = 43    ;fv = 10
value = 0
ignorehitpause = 1

[State 2002, VarSet]
type = VarSet
trigger1 = time = 0
v = 14
value = 0
ignorehitpause = 1

[State 2002, LifeAdd]
type = LifeAdd
trigger1 = time % 2 = 0
value = -ifelse(life > lifemax/2, 2, 1)*floor(lifemax/1000.0)
kill = 0
absolute = 1

[State 2002, PowerAdd]
type = PowerAdd
trigger1 = time % 2 = 0
value = -(powermax/1000)
ignorehitpause = 1

[State 2002, PosSet]
type = PosAdd
trigger1 = !IsHelper && numhelper(800) > 0 && roundstate >= 2
x = ((helper(800), pos x - pos x)*facing)/ifelse(var(53) = 2, 16, 4)
y = (helper(800), pos y - pos y)/ifelse(var(53) = 2, 8, 4)
ignorehitpause = 1

[State 2002, PlaySnd]
type = PlaySnd
triggerall = numhelper(2001)
trigger1 = gametime % 60 = 0 && helper(2001), var(0) = 1 && (life > lifemax/4 || life <= lifemax/6)
value = S250,0
channel = 3
ignorehitpause = 1

[State 704, PlaySnd]
type = PlaySnd
trigger1 = gametime % 60 = 0 && life > lifemax/2
value = S704,1
channel = -1
ignorehitpause = 1

[State 2002, ChangeAnim]
type = ChangeAnim
trigger1 = anim != 15 && life <= lifemax/4
value = 15
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 2002, PalFXWiz]
type = PalFX
trigger1 = life < lifemax / 8
time = 1
add = 0,0,128*floor(life/(lifemax/8.0))
mul = 256,256,256
color = 256*floor(life/(lifemax/8.0))
ignorehitpause = 1

[State 2002, ChangeState]
type = ChangeState
triggerall = numhelper(2001)
trigger1 = helper(2003), numtarget && helper(2001), stateno = 2004
value = 2006
ctrl = 0
ignorehitpause = 1

[State 2002, ChangeState]
type = ChangeState
trigger1 = !numhelper(2001)
value = 0
ctrl = 1
ignorehitpause = 1

; Metroid Brain
[Statedef 2003]
type = A
movetype = A
physics = N
anim = 2002
ctrl = 0
sprpriority = 5

[State 2008, Trans]
type = Trans
triggerall = numhelper(2001)
trigger1 = helper(2001), stateno = 2008 && helper(2001), time >= 40
trans = addalpha
alpha = 256-(helper(2001), time-40), (helper(2001), time-40)
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 2004, PalFXWiz]
type = PalFX
triggerall = numhelper(2001)
trigger1 = helper(2001), stateno != 2007
trigger2 = helper(2001), stateno = 2007 && gametime % 2
time = 1
mul = 200+floor(56.0*(1.0*helper(2001), life/helper(2001), Lifemax)),40+floor(1.0*216.0*(helper(2001), life/helper(2001), Lifemax)),256
color = floor(256.0*(1.0*helper(2001), life/helper(2001), Lifemax))
ignorehitpause = 1

[State 2007, PalFX]
type = PalFX
triggerall = numhelper(2001)
trigger1 = helper(2001), stateno = 2007 && gametime % 2 = 0
time = 1
add = 256,256,256
mul = 200,200,200
ignorehitpause = 1

[State 2003, VarAdd]
type = VarAdd
trigger1 = helper(4500), stateno = 2002
v = 1    ;fv =
value = 1
ignorehitpause = 1

[State 2002, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(0) = %d var(1) = %d"
params = var(0), var(1)
ignorehitpause = 1

[State 2002, VarSet]
type = VarSet
trigger1 = 1
v = 0    ;fv = 10
value = 0
ignorehitpause = 1

[State 2002, VarSet]
type = VarSet
triggerall = helper(4500), stateno = 2002
trigger1 = var(1) = [64, 128]
trigger2 = var(1) = [256, 320]
trigger3 = var(1) = [448, 512]
trigger4 = var(1) = [640, 704]
v = 0
value = 1
ignorehitpause = 1

[State 2002, VarSet]
type = VarSet
triggerall = helper(4500), stateno = 2002
trigger1 = var(1) = [0, 32]
trigger2 = var(1) = [160, 224]
trigger3 = var(1) = [352, 416]
trigger4 = var(1) = [544, 608]
trigger5 = var(1) = [736, 800]
v = 0    ;fv = 10
value = -1
ignorehitpause = 1

[State 2003, PosSet]
type = PosSet
trigger1 = 1
x = parent, pos x
y = parent, pos y
ignorehitpause = 1

[State 2003, ChangeAnim]
type = ChangeAnim
trigger1 = parent, var(0) = 1 && anim = 2002
value = 2003

[State 2003, ChangeAnim]
type = ChangeAnim
trigger1 = parent, var(0) != 1 && anim = 2003
value = 2002

[State 2001, HitDef]
type = HitDef
trigger1 = !numtarget && numhelper(2001)
trigger1 = (helper(2001), stateno = 2001 || helper(2001), stateno = 2004) && helper(2001), var(7) = 4
attr = A,NT        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
affectteam = E
animtype = light          ;light,medium,hard,back,up,diagup
air.animtype = light
priority = 8,Hit   ;Hit,Miss,Dodge
sparkno = -1
id = 2002
guard.sparkno = -1
sparkxy = 0,0
kill = 1
p2stateno = 2005
guard.kill = 1
fall.kill = 1
numhits = 0

[State 2004, VarSet]
type = VarSet
trigger1 = numtarget && numhelper(2001)
trigger1 = helper(2001), stateno = 2001 || helper(2001), stateno = 2004
v = 19    ;fv = 10
value = 1
ignorehitpause = 1

[State 2004, VarSet]
type = VarSet
trigger1 = numtarget
v = 20    ;fv = 10
value = target, id
ignorehitpause = 1

[State 2004, TargetLifeAdd]
type = TargetLifeAdd
triggerall = numtarget && numhelper(2001)
trigger1 = target, life < target, lifemax && helper(2001), stateno = 2004
value = ceil(target,lifemax/1000.0)
kill = 0
absolute = 1
ignorehitpause = 1

[State 2004, PlaySnd]
type = PlaySnd
trigger1 = numtarget && numhelper(2001)
trigger1 = helper(2001), stateno = 2004 && helper(2001), time = 1
value = S150,0
channel = 9
loop = 1
ignorehitpause = 1
persistent = 0

[State 2004, StopSnd]
type = StopSnd
trigger1 = helper(4500), var(0) >= 6
channel = 9
persistent = 0

[State 2008, TargetState]
type = TargetState
trigger1 = numtarget && numhelper(2001)
trigger1 = helper(2001), stateno = 2008
value = 2009
ignorehitpause = 1
persistent = 0

[State 2003, DefenceMulSet]
type = DestroySelf
trigger1 = !numhelper(2001)
ignorehitpause = 1

; METROID SCENE 2 - Helping Ally and suicide!
[Statedef 2004]
type = A
movetype = A
physics = N
ctrl = 0
sprpriority = 5
velset = 0, 0
hitdefpersist = 1

[State 2004, VarSet]
type = VarSet
trigger1 = var(10) && !time
v = 10
value = 0
ignorehitpause = 1

[State 2004, VarSet]
type = VarSet
trigger1 = var(11) && !time
v = 11
value = 0
ignorehitpause = 1

[State 2004, VarSet]
type = VarSet
trigger1 = var(12) && !time
v = 12
value = 0
ignorehitpause = 1

[State 2004, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 2007
time = 1
ignorehitpause = 1

[State 2004, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "life %d"
params = life
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 2004, PalFXWiz]
type = PalFX
trigger1 = 1
time = 1
mul = 256,256,128+floor(128*life/Lifemax)
color = 128+floor(128*life/Lifemax)
ignorehitpause = 1

;[State 2001, HitDef]
;type = HitDef
;trigger1 = !numtarget
;attr = A,NT        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
;hitflag = MAF        ;HLAFD+-
;guardflag = MA         ;HLA
;affectteam = E
;animtype = light          ;light,medium,hard,back,up,diagup
;air.animtype = light
;priority = 8,Hit   ;Hit,Miss,Dodge
;sparkno = -1
;id = 2002
;guard.sparkno = -1
;sparkxy = 0,0
;kill = 1
;p2stateno = 2005
;guard.kill = 1
;fall.kill = 1
;numhits = 0

[State 2004, PosSet]
type = PosSet
triggerall = numhelper(2003)
triggerall = helper(2003), numtarget && helper(4500), var(0) < 6 && PlayerIDExist(helper(2003), var(20))
trigger1 = playerID(helper(2003), var(20)), alive &&  playerID(helper(2003), var(20)), life < playerID(helper(2003), var(20)), lifemax
x = playerID(helper(2003), var(20)), pos x + playerID(helper(2003), var(20)), Const(size.mid.pos.x) + ((random % 3)*playerID(helper(2003), var(20)),facing)*Const(size.xscale)
y = playerID(helper(2003), var(20)), pos y + playerID(helper(2003), var(20)), Const(size.mid.pos.y) - (random % 3)*Const(size.yscale)
ignorehitpause = 1

[State 2004, VarSet]
type = VarSet
triggerall = numhelper(2003) && !var(10)
triggerall = helper(2003), numtarget && PlayerIDExist(helper(2003), var(20))
trigger1 = helper(4500), var(0) >= 6 && playerID(helper(2003), var(20)), life >= playerID(helper(2003), var(20)), lifemax
v = 10
value = time
ignorehitpause = 1

[State 2004, SprPriority]
type = SprPriority
trigger1 = 1
value = 5
ignorehitpause = 1

[State 2004, VarSet]
type = VarSet
triggerall = numhelper(2003)
triggerall = helper(2003), numtarget && PlayerIDExist(helper(2003), var(20))
trigger1 = helper(4500), var(0) = 6 && playerID(helper(2003), var(20)), life >= playerID(helper(2003), var(20)), lifemax
v = 11
value = floor(pos x + 2*Const(size.xscale))
ignorehitpause = 1
persistent = 0

[State 2004, VarSet]
type = VarSet
triggerall = numhelper(2003)
triggerall = helper(2003), numtarget && PlayerIDExist(helper(2003), var(20))
trigger1 = helper(4500), var(0) = 6 && playerID(helper(2003), var(20)), life >= playerID(helper(2003), var(20)), lifemax
v = 12
value = floor(pos y - 80*Const(size.yscale))
ignorehitpause = 1
persistent = 0

[State 2004, VarSet]
type = VarSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && time - var(10) = 60
v = 11
value = floor(pos x + (160*facing)*Const(size.xscale))
ignorehitpause = 1
persistent = 0

[State 2004, VarSet]
type = VarSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6  && time - var(10) = 60
v = 12
value = floor(pos y)
ignorehitpause = 1
persistent = 0

[State 2004, VarSet]
type = VarSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && time - var(10) = 200
v = 11
value = floor(root, pos x+root, Const(size.mid.pos.x))
ignorehitpause = 1
persistent = 0

[State 2004, VarSet]
type = VarSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6  && time - var(10) = 200
v = 12
value = floor(root, pos y+root, Const(size.mid.pos.y))
ignorehitpause = 1
persistent = 0

[State 2001, VelAdd]
type = VelAdd
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && helper(4500), stateno = 2006 && time-var(10) < 200
x = ((var(11) - pos x)/256)*facing
y = (var(12) - pos y)/256
ignorehitpause = 1

[State 2001, VelAdd]
type = VelAdd
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && helper(4500), stateno = 2006 && time-var(10) >= 200
x = ((var(11) - pos x)/32)*facing
y = (var(12) - pos y);/32
ignorehitpause = 1

[State 2001, VelSet]
type = VelSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && helper(4500), stateno = 2006 && time-var(10) < 200
x = ifelse(vel x > 2*Const(size.xscale), 2.0*Const(size.xscale), ifelse(vel x < -2*Const(size.xscale), -2.0*Const(size.xscale), vel x))
y = ifelse(vel y > 2*Const(size.yscale), 2.0*Const(size.yscale), ifelse(vel y < -2*Const(size.yscale), -2.0*Const(size.yscale), vel y))

[State 2001, VelSet]
type = VelSet
triggerall = var(10)
trigger1 = helper(4500), var(0) = 6 && helper(4500), stateno = 2006 && time-var(10) >= 200
x = ifelse(vel x > 6*Const(size.xscale), 6.0*Const(size.xscale), ifelse(vel x < -6*Const(size.xscale), -6.0*Const(size.xscale), vel x))
y = ifelse(vel y > 6*Const(size.yscale), 6.0*Const(size.yscale), ifelse(vel y < -6*Const(size.yscale), -6.0*Const(size.yscale), vel y))

; METROID SCENE 2 - Ally getting life!
[Statedef 2005]
type = S
movetype = H
physics = N
ctrl = 0
sprpriority = 5

[State 2005, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2005, Gravity]
type = Gravity
trigger1 = Pos Y < 0

[State 2005, PosSet]
type = PosSet
trigger1 = Pos Y >= 0
y = 0
ignorehitpause = 1

[State 2005, VelSet]
type = VelSet
trigger1 = Pos Y >= 0
x = 0
y = 0
ignorehitpause = 1

[State 2005, ChangeAnim2]
type = ChangeAnim
trigger1 = time = 0 && anim != 5300 && selfanimexist(5300)
value = 5300
ignorehitpause = 1

[State 2005, SprPriority]
type = SprPriority
trigger1 = 1
value = -1
ignorehitpause = 1

; MOTHER BRAIN RETURNS
[Statedef 2006]
type = S
movetype = H
physics = N
ctrl = 0

[State 2006, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = timerfreeze

[State 2006, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2006, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "var(0) = %d SCREENPOS X %f"
params = var(0), screenpos x
ignorehitpause = 1

[State 2006, VarSet]
type = VarSet
trigger1 = time = 0 && var(0)
v = 0
value = 0
ignorehitpause = 1

; MUDAR A COLORAÇÃO
[State 2006, PalFXWiz]
type = PalFX
trigger1 = life < lifemax / 8
time = 1
mul = 256,256,256
color = 256*floor(life/(lifemax/8.0))
ignorehitpause = 1

; RESSUCITAR MISTERIOSAMENTE
[State 2006, LifeAdd]
type = LifeAdd
trigger1 = life < lifemax && time >= 120
value = 1*ceil(lifemax/1000.0)
absolute = 1
ignorehitpause = 1

; LEVANTAR
[State 2006, VarSet]
type = VarSet
trigger1 = !var(0) && life >= floor(lifemax/4)
v = 0
value = 1
ignorehitpause = 1

; GRITAR DE RAIVA
[State 2006, VarSet]
type = VarSet
trigger1 = var(0) = 1 && life >= floor(lifemax/3)
v = 0
value = 2
ignorehitpause = 1

; IR EM DIREÇÃO AO METROID
[State 2006, VarSet]
type = VarSet
trigger1 = var(0) = 2 && life >= floor(lifemax/2)
v = 0
value = 3
ignorehitpause = 1

; DANIFICAR O METROID
[State 2006, VarSet]
type = VarSet
triggerall = numhelper(2001)
trigger1 = var(0) = 3 && abs(helper(2001), pos x - pos x) <= 100*Const(size.xscale)
v = 0
value = 4
ignorehitpause = 1

; ANDAR PARA TRÁS CASO ESTEJA MUITO PRÓXIMO AO METROID
[State 2006, VarSet]
type = VarSet
triggerall = numhelper(2001)
trigger1 = var(0) = 4 && helper(2001), life < 30 && !numprojid(760)
v = 0
value = 5
ignorehitpause = 1

; OBSERVAR O MOVIMENTO DO METROID
; PREPARAR A CILADA (É UMA CILADA BINO!)
; ACABAR COM A ALEGRIA DO METROID E DO OPONENTE.
[State 2006, VarSet]
type = VarSet
triggerall = numhelper(2001)
trigger1 = var(0) = 5 && abs(helper(2001), pos x - pos x) > 100*Const(size.xscale)
v = 0
value = 6
ignorehitpause = 1

; OBSERVAR O MOVIMENTO DO METROID MORRENDO
[State 2006, VarSet]
type = VarSet
triggerall = numhelper(2001)
trigger1 = var(0) = 6 && !helper(2001), life
v = 0
value = 7
ignorehitpause = 1

[State 2006, VarSet]
type = VarSet
trigger1 = !var(54)
v = 54
value = 1
ignorehitpause = 1

[State 2006, VarSet]
type = ChangeState
trigger1 = !numhelper(2001)
value = 4500
ctrl = 1
ignorehitpause = 1

; METROID HIT
[Statedef 2007]
type = U
movetype = H
physics = U
ctrl = 0
hitdefpersist = 1
velset = 0,0

[State 2007, LifeAdd]
type = LifeAdd
trigger1 = time = 0
value = -(ceil(GetHitVar(damage)*(lifemax/1000.0))-GetHitVar(damage))

kill = 0
ignorehitpause = 1

[State 2007, PosSet]
type = PosSet
triggerall = helper(2003), numtarget && helper(4500), var(0) < 6 && PlayerIDExist(helper(2003), var(20))
trigger1 = playerID(helper(2003), var(20)), alive
x = playerID(helper(2003), var(20)), pos x + playerID(helper(2003), var(20)), Const(size.mid.pos.x) + ((random % 3)*playerID(helper(2003), var(20)),facing)*Const(size.xscale)
y = playerID(helper(2003), var(20)), pos y + playerID(helper(2003), var(20)), Const(size.mid.pos.y) - (random % 3)*Const(size.yscale)
ignorehitpause = 1

[State 2007, ChangeState]
type = ChangeState
trigger1 = helper(4500), stateno = 2006 && helper(4500), var(0) >= 6 && !life
value = 2008
ctrl = 0
ignorehitpause = 1

[State 2007, LifeAdd]
type = LifeAdd
trigger1 = GetHitVar(damage) > life && helper(4500), var(0) < 6
value = GetHitVar(damage)
ignorehitpause = 1

[State 2004, HitOverride]
type = HitOverride
trigger1 = 1
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 2007
time = 1
ignorehitpause = 1

[State 2007, PalFX]
type = PalFX
trigger1 = gametime % 2 = 0
time = 1
add = 256,256,256
mul = 200,200,200
ignorehitpause = 1

[State 2004, PalFXWiz]
type = PalFX
trigger1 = gametime % 2
time = 1
mul = 256,256,128+floor(128*life/Lifemax)
color = 128+floor(128*life/Lifemax)
ignorehitpause = 1

[State 2007, ChangeState]
type = ChangeState
trigger1 = HitOver;time > 10
value = 2004
ignorehitpause = 1

; METROID DEATH
[Statedef 2008]
type = U
movetype = A
physics = U
anim = 2007
ctrl = 0
velset = 0, -2*Const(size.yscale)

[State 2008, VelMul]
type = VelMul
trigger1 = time < 40
x = 1
y = 0.2
ignorehitpause = 1

[State 2008, VelSet]
type = VelSet
trigger1 = time >= 40
x = 0
y = 0.3*Const(size.yscale)
ignorehitpause = 1

[State 2008, Trans]
type = Trans
trigger1 = time >= 40
trans = addalpha
alpha = 256-(time-40), (time-40)
ignorehitpause = 1

[State 2008, Explod]
type = Explod
trigger1 = time >= 40 && time % 4 = 0
anim = 2
ID = 2
pos = 0,0
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
random = floor(78),floor(78)
removetime = -2
sprpriority = 5
ontop = 1
shadow = 0,0,0
ownpal = 1
ignorehitpause = 1

[State 2008, PlaySnd]
type = PlaySnd
trigger1 = time >= 40 && time % 15 = 0
value = S100,0
channel = -1
ignorehitpause = 8

[State 2008, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = nobardisplay
flag2 = noBG
flag3 = noFG
ignorehitpause = 1

[State 2008, PlaySnd]
type = PlaySnd
trigger1 = time = 0
value = S2001,1
ignorehitpause = 1

[State 2008, PalFXWiz]
type = PalFX
trigger1 = 1
time = 1
mul = 256,256,128+floor(128*life/Lifemax)
color = 128+floor(128*life/Lifemax)
ignorehitpause = 1

[State 2008, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2008, TargetState]
type = TargetState
trigger1 = numtarget
value = 2009
ignorehitpause = 1

[State 2008, DestroySelf]
type = DestroySelf
trigger1 = time > 295
ignorehitpause = 1

; Aliado irritado
[Statedef 2009]
type = U
movetype = I
physics = U
ctrl = 0

[State 2009, NotHitBy]
type = NotHitBy
trigger1 =  1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2009, ChangeAnim]
type = ChangeAnim
trigger1 = 1
value = anim
elem = animelemno(0)
ignorehitpause = 1

[State 2009, PalFXWiz]
type = PalFX
trigger1 = time % 20 = 0
time = 20
sinadd = 0,128,128,20
ignorehitpause = 1

[State 2009, ChangeState]
type = SelfState
trigger1 = time > 295
value = 0
ctrl = 1
ignorehitpause = 1

; Aliado irritado
[Statedef 2010]
type = U
movetype = H
ctrl = 0

[State 2010, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State 2010, ChangeState]
type = ChangeState
trigger1 = helper(4500), stateno != 2002 && time > 1
value = 0
ctrl = 1
ignorehitpause = 1

; Corpo
[Statedef 3000]
type = S
movetype = A
physics = S
anim = 40
ctrl = 0
sprpriority = 0

[State 3000, HitDef]
type = HitDef
trigger1 = 1
attr = S,NA        ;SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
hitflag = MAF        ;HLAFD+-
guardflag = MA         ;HLA
animtype = light          ;light,medium,hard,back,up,diagup
air.animtype = light
priority = 4,Hit   ;Hit,Miss,Dodge
sparkno = -1
guard.sparkno = -1
sparkxy = 0,0
hitsound = 0,0
guardsound = 0,0
ground.type = Low      ;Low,Trip,None
guard.dist = 0
ground.velocity = -14,0
air.velocity = -14,0
p2facing = 1
numhits = 0
fall = 1
fall.recover = 1
ignorehitpause = 1
ground.cornerpush.veloff = 0
sprpriority = 0

[State 3000, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && helper(4500), var(54) && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 2) || (helper(60), anim = 21 && helper(60), animelemno(0) = 6)
x = helper(60), pos X - (7 * facing)*Const(size.xscale)
y = helper(60), pos Y - 66*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 1) || (helper(60), anim = 21 && helper(60), animelemno(0) = 7)
x = helper(60), pos X - (1 * facing)*Const(size.xscale)
y = helper(60), pos Y - 65*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 3) || (helper(60), anim = 21 && helper(60), animelemno(0) = 5)
x = helper(60), pos X - (8 * facing)*Const(size.xscale)
y = helper(60), pos Y - 64*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 4) || (helper(60), anim = 21 && helper(60), animelemno(0) = 4)
x = helper(60), pos X - (3 * facing)*Const(size.xscale)
y = helper(60), pos Y - 67*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 5) || (helper(60), anim = 21 && helper(60), animelemno(0) = 3)
x = helper(60), pos X
y = helper(60), pos Y - 67*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 6) || (helper(60), anim = 21 && helper(60), animelemno(0) = 2)
x = helper(60), pos X - (1 * facing)*Const(size.xscale)
y = helper(60), pos Y - 71*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 20 && helper(60), animelemno(0) = 7) || (helper(60), anim = 21 && helper(60), animelemno(0) = 1)
x = helper(60), pos X - (2 * facing)*Const(size.xscale)
y = helper(60), pos Y - 67*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 10 && helper(60), animelemno(0) = 1) || (helper(60), anim = 12 && helper(60), animelemno(0) = 2)
x = helper(60), pos X + (1 * facing)*Const(size.xscale)
y = helper(60), pos Y - 54*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = (helper(60), anim = 10 && helper(60), animelemno(0) = 2) || (helper(60), anim = 12 && helper(60), animelemno(0) = 1)
x = helper(60), pos X + (1 * facing)*Const(size.xscale)
y = helper(60), pos Y - 41*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = helper(60), anim = 11
x = helper(60), pos X + (4 * facing)*Const(size.xscale)
y = helper(60), pos Y - 38*Const(size.yscale)
ignorehitpause = 1

[State 3000, PosSet]
type = PosSet
trigger1 = helper(60), anim = 6 || ((helper(60), anim = 20 || helper(60), anim = 21) && helper(60), animelemno(0) = 8)
x = helper(60), pos X + (3 * facing)*Const(size.xscale)
y = helper(60), pos Y - 63*Const(size.yscale)
ignorehitpause = 1

[State 4000, AssertSpecial]
type = AssertSpecial
triggerall = numhelper(60)
trigger1 = helper(60), Pos Y > 0
flag = noshadow

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 900, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

[State 3000, ChangeAnim]
type = ChangeAnim
trigger1 = helper(4500), stateno = 703 && helper(4500), time <= 3 && root, numhelper(1008) <= 0 && anim != 39
value = 39
ignorehitpause = 1

[State 3000, PlaySnd]
type = PlaySnd
trigger1 = helper(4500), stateno = 703 && root, numhelper(1008) <= 0 && anim = 39 && animtime = 0
value = S703,0
channel = -1
ignorehitpause = 1

[State 3000, ChangeAnim]
type = VarSet
trigger1 = helper(4500), stateno = 703 && root, numhelper(1008) <= 0 && anim = 39 && animtime = 0
v = 11
value = time
ignorehitpause = 1

[State 3000, Helper]
type = Helper
trigger1 = helper(4500), stateno = 703 && root, numhelper(1008) <= 0 && anim = 39 && animtime = 0
helpertype = normal ;player
name = "Big Boom"
ID = 1008
stateno = 1008
pos = floor(52*Const(size.xscale)),floor(-35*Const(size.yscale))
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
ignorehitpause = 1

[State 3000, ChangeAnim]
type = ChangeAnim
trigger1 = anim = 39 && animtime = 0
value = 40
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

[State 3000, NotHitBy]
type = NotHitBy
trigger1 = time = 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1

[State 3000, VarAdd]
type = VarAdd
trigger1 = !root, Alive
v = 10
value = 1
ignorehitpause = 1

[State 3000, PlaySnd]
type = PlaySnd
trigger1 = !root, Alive && time % 11 = 0
value = S100,0
channel = 2
ignorehitpause = 1

[State 3000, Explod]
type = Explod
trigger1 = !root, Alive && time % 4 = 0
anim = ifelse(random <= 500, 8, ifelse(random <= 500, 63, 2))
ID = 2
pos = 0,0
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 95,90
removetime = -2
sprpriority = 5
ownpal = 1
ignorehitpause = 1

[State 3000, PlayerPush]
type = PlayerPush
trigger1 = 1
value = 0
ignorehitpause = 1

[State 3000, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

[State 3000, DestroySelf]
type = DestroySelf
trigger1 =  var(10) >= 300
ignorehitpause = 1

; Pernas
[Statedef 4000]
type = S
movetype = I
physics = S
anim = 6
ctrl = 0
sprpriority = 1

[State 4000, ChangeAnim6]
type = ChangeAnim
;triggerall = !((pos x > enemynear, pos x && enemynear, pos x > root, pos x) && anim = [20, 21])
;triggerall = !((pos x < enemynear, pos x && enemynear, pos x < root, pos x) && anim = [20, 21])
triggerall = !(helper(4500), stateno = 2002 && root, life <= root, lifemax / 8) && root, stateno != 200
triggerall = !(helper(4500), stateno = 2006 && (helper(4500), var(0) = 3 || helper(4500), var(0) = 5))
trigger1 = helper(4500), stateno != 2002 && anim = [20, 21]
trigger1 = (!(root, command = "holdback" || root, command = "holdfwd") || ((root, command = "holdback" && backedgebodydist <= 0) || (root, command = "holdfwd" && root, frontedgebodydist <= 50))) && root, ctrl && anim != 6
trigger2 = anim = 12 && animtime = 0 && helper(4500), stateno != 2002; && !root, command != "holddown"
trigger3 = !root, ctrl && helper(4500), stateno != 2002 && anim = [20, 21]
trigger4 = numhelper(2003) && helper(4500), stateno != 2006
trigger4 = helper(2003), var(0) = 0 && helper(4500), stateno != 2006
value = 6

[State 4000, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && helper(4500), var(54) && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1

[State 705, PalFX]
type = PalFX
trigger1 = helper(4500), stateno = 704 && helper(4500), var(13) >= 2 && root, numhelper(705)
trigger2 = helper(4500), stateno = 2002 && root, life > root, lifemax/2
time = 1
add = 128-helper(4500), var(40),128-helper(4500), var(41),128-helper(4500), var(42)
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 4000, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2002 && root, life < root, lifemax / 8
time = 1
add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 3000, PalFXWiz]
type = PalFX
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
color = 256
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 4000, PalFXWiz]
type = PalFX
trigger1 = helper(4500), stateno = 2006 && root, life < root, lifemax / 8
time = 1
mul = 256,256,256
color = floor(256*(root, life/(root, lifemax/8.0)))
ignorehitpause = 1

[State 4000, AssertSpecial]
type = AssertSpecial
trigger1 = Pos Y > 0
flag = noshadow

[State 4000, PosAdd]
type = PosAdd
trigger1 = Pos Y > 0 && roundstate = 2 && time % ceil(3/Const(size.yscale)) = 0
y = -1
ignorehitpause = 1

[State 3000, PlayerPush]
type = PlayerPush
trigger1 = helper(4500), ctrl
value = 1
ignorehitpause = 1

; Agaixar
[State 4000, ChangeAnim1]
type = ChangeAnim
triggerall = numhelper(800) && anim != [10, 11]
trigger1 = root, command = "holddown" && helper(4500), ctrl && !helper(800), var(1)
trigger2 = helper(4500), stateno = 2002 && root, life <= root, Lifemax/8
trigger3 = (helper(4500), stateno = 2006 && !helper(4500), var(0)) || pos y > 0
value = 10

; Permanecer agaixado
[State 4000, ChangeAnim2]
type = ChangeAnim
triggerall = numhelper(800) && anim = 10 && animtime = 0
trigger1 = root, command = "holddown" && helper(4500), ctrl && !helper(800), var(1)
trigger2 = helper(4500), stateno = 2002 && root, life <= root, Lifemax/8
trigger3 = (helper(4500), stateno = 2006 && !helper(4500), var(0)) || pos y > 0
value = 11

; Levantar
[State 4000, ChangeAnim3]
type = ChangeAnim
triggerall = !(helper(4500), stateno = 2002 && root, life <= lifemax/8) && !(helper(4500), stateno = 2006 && !helper(4500), var(0)) && pos y <= 0
trigger1 = (root, command != "holddown" || !helper(4500), ctrl)  && (anim = 10 || (anim = 11))
value = 12

; Andar para frente
[State 4000, ChangeAnim4]
type = ChangeAnim
triggerall = numhelper(800) && anim != 20 && root, frontedgebodydist > 50 && alive && root, stateno != 200 && anim != [10, 12]
trigger1 = root, command = "holdfwd" && helper(4500), ctrl && !helper(800), var(1) && !root, var(59)
trigger2 = numhelper(2003)
trigger2 = helper(2003), var(0) = 1 && anim != 20 && helper(4500), stateno != 2006
trigger3 = helper(4500), stateno = 2006 && helper(4500), var(0) = 3
value = 20

; Andar para trás
[State 4000, ChangeAnim5]
type = ChangeAnim
triggerall = numhelper(800) && anim != 21 && backedgebodydist > 0 && root, alive && helper(4500), stateno != 704 && anim != [10, 12]
trigger1 = (root, command = "holdback" && helper(4500), ctrl) && !helper(800), var(1)
trigger2 = pos x > enemynear, pos x && enemynear, pos x > root, pos x && ctrl && !helper(800), var(1)
trigger3 = pos x < enemynear, pos x && enemynear, pos x < root, pos x && ctrl && !helper(800), var(1)
trigger4 = numhelper(2003) && helper(4500), stateno != 2006
trigger4 = helper(2003), var(0) = -1
trigger5 = helper(4500), stateno = 2006 && helper(4500), var(0) = 5
trigger6 = root, stateno = 200 && !helper(800), var(1)
value = 21

[State 4000, VelSet]
type = VelSet
triggerall = anim = 20
trigger1 = animelemno(0) = [1,2]
trigger2 = animelemno(0) = [5,6]
x = Const(velocity.walk.fwd.x)*Const(size.xscale)

[State 4000, VelSet]
type = VelSet
triggerall = anim = 21
trigger1 = animelemno(0) = [3,4]
trigger2 = animelemno(0) = [7,8]
x = ifelse(helper(4500), stateno = 2002, -Const(velocity.walk.fwd.x)*Const(size.xscale), Const(velocity.walk.back.x)*Const(size.xscale))

[State 4000, VelSet]
type = EnvShake
triggerall = anim = 20
trigger1 = animelemno(0) = [1,2]
trigger2 = animelemno(0) = [5,6]
time = 15
freq = 60
ampl = -4
phase = 90

[State 4000, VelSet]
type = EnvShake
triggerall = anim = 21
trigger1 = animelemno(0) = [3,4]
trigger2 = animelemno(0) = [7,8]
time = 15
freq = 60
ampl = -4
phase = 90

[State 4000, Turn]
type = Turn
trigger1 = root, facing != facing
ignorehitpause = 1

[State 4000, DestroySelf]
type = DestroySelf
trigger1 = numhelper(50) <= 0
ignorehitpause = 1

[State 4000, NotHitBy]
type = NotHitBy
trigger1 = 1
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

; Cabeça
[Statedef 4500]
type = S
movetype = I
physics = N
anim = root, anim
ctrl = 1
sprpriority = -5

[State 4500, CtrlSet]
type = CtrlSet
triggerall = numhelper(60)
trigger1 = !ctrl
trigger1 = helper(60), Pos Y <= 0
trigger2 = ctrl
trigger2 = helper(60), Pos Y > 0
value = ifelse(ctrl, 0, 1)
ignorehitpause = 1

; Shiny Laser
[State -1, Shiny Laser]
type = ChangeState
value = 704
triggerall = helper(4500), ctrl && roundno > 1 && root, life <= root, lifemax/4 && root, alive && !helper(4500), var(54) && !numhelper(705)
trigger1 = root, command = "y" && !root, var(59)
trigger2 = root, var(59) && root, roundstate = 2 && (prevstateno != 704 || time >= 120)

; Plasma
[State 4500, Plasma]
type = ChangeState
value = 700
triggerall = helper(4500), ctrl && roundno > 1 && !root, numprojid(700) && root, power >= 300 && root, alive && !helper(600), var(0) && helper(600), anim = 600
trigger1 = root, command = "a" && !root, var(59)
trigger2 = root, var(59) && prevstateno != 704 && !helper(800), var(1) && random < 50 && roundstate = 2 && prevstateno != 700

; Mini Laser
[State 4500, Mini Laser]
type = ChangeState
value = 701
triggerall = !root, numprojid(701) && helper(4500), ctrl && roundno > 1 && root, alive && root, numhelper(500)
trigger1 = root, command = "b" && !root, var(59)
trigger2 = root, numenemy && root, var(59) && prevstateno != 704 && !helper(800), var(1) && random < 100 && roundstate = 2
trigger2 = enemynear(ifelse(enemynear(0), alive, 0, 1)), pos y > helper(500), pos y-13
trigger2 = enemynear(ifelse(enemynear(0), alive, 0, 1)), pos y-enemynear(ifelse(enemynear(0), alive, 0, 1)),const(size.height) < helper(500), pos y+13

; Bomb
[State -1, Bomb]
type = ChangeState
value = 702
triggerall = helper(4500), ctrl && roundno > 1 && root, numhelper(1007) <= 0 && root, alive && prevstateno != 704 && helper(600), anim = 600
trigger1 = root, command = "c" && !root, var(59)
trigger2 = root, var(59) && roundstate = 2

; Supernova Beam
[State -1, Big Boom]
type = ChangeState
value = 703
triggerall = helper(4500), ctrl && roundno > 1 && numhelper(1008) <= 0 && root, power >= 300 && root, alive && !helper(4500), var(54)
triggerall = helper(800), var(1) && helper(50), time - helper(50), var(11) >= 300
trigger1 = root, command = "x" && !root, var(59)
trigger2 = root, var(59) && root, roundstate = 2

; Taunt
[State -1, Taunt]
type = ChangeState
value = 195
trigger1 = root, command = "start" && root, alive && ctrl

[State 4500, ChangeAnim]
type = ChangeAnim
trigger1 = anim != root, anim && (root, anim = 0 || root, anim = 15)
value = root, anim
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
trigger1 = Roundno <= 1 && !IsHelper && !Alive
time = 1
add = 100,100,0
mul = 200,200,200
color = 0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
trigger1 = Roundno >= 2 && !root, Alive
time = 1
color = 0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
triggerall = !IsHelper && alive
trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
trigger2 = helper(4500), stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1


[State 4500, PalFX]
type = PalFX
trigger1 = root, Alive && gametime % 2 = 0 && root, stateno = [200, 201]
time = 1
add = 230,230,230
mul = 256,256,256
color = 256
ignorehitpause = 1
persistent = 2

;[State 4500, PalFX]
;type = PalFX
;trigger1 = root, stateno = 704 && root, var(13) >= 2 && root, numhelper(705)
;trigger2 = root, stateno = 2002 && root, life > root, lifemax/2
;time = 1
;add = 128-root, var(40),128-root, var(41),128-root, var(42)
;mul = 256,256,256
;color = 256
;ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
;[State 4500, PalFXWiz]
;type = PalFX
;trigger1 = root, stateno = 2002 && root, life < root, lifemax / 8
;time = 1
;add = 0,0,floor(128*(root, life/(root, lifemax/8.0)))
;mul = 256,256,256
;color = floor(256*(root, life/(root, lifemax/8.0)))
;ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
;[State 4500, PalFXWiz]
;type = PalFX
;trigger1 = enemynear, name = "Super Metroid" && (root, stateno = 216 || root, stateno = 215)
;trigger2 = root, stateno = 2002 && root, life >= root, lifemax/8 && root, life < root, lifemax/2
;time = 1
;add = 0,0,128
;mul = 256,256,256
;color = 256
;ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
;[State 4500, PalFXWiz]
;type = PalFX
;trigger1 = root, stateno = 2006 && root, life < root, lifemax / 8
;time = 1
;mul = 256,256,256
;color = floor(256*(root, life/(root, lifemax/8.0)))
;ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State 4500, PalFXWiz]
type = PalFX
trigger1 = root, stateno != 704 && root, stateno != 200 && root, stateno != 2006 && gametime % 60 = 0 && root, Alive && !root, var(4)
time = 60
add = 30,30,30
mul = 256,256,256
sinadd = 15,15,15,60
color = 256
ignorehitpause = 1

[State 4500, BindToRoot]
type = BindToRoot
trigger1 = time = 0
time = -1
facing = 1
pos = 0,0
ignorehitpause = 1

[State 4500, NotHitBy]
type = NotHitBy
trigger1 = time = 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = -1
ignorehitpause = 1


;---------------------------------------------------------------------------
; Override common states (use same number to override) :
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; States that are always executed (use statedef -2)
;---------------------------------------------------------------------------

;---------------------------------------------------------------------------
; States that are executed when in self's state file (use statedef -3)
;---------------------------------------------------------------------------

[Statedef -2]

; WINANE XOR 3 var AI
; Within StateDef -2, none of your own AI-related code should be placed
; above these next two controllers.

[State -2, Simplifier]
type = VarSet
triggerall = !IsHelper
trigger1 = var(58) = 1
trigger2 = var(59):=0
var(59) = 1
IgnoreHitPause = 1

[State -2, LifeSet]
type = LifeSet
triggerall = numhelper(4500)
trigger1 = helper(4500), stateno = 2002 || helper(4500),stateno = 2006
value = helper(4500), life
ignorehitpause = 1

[State -2, NotHitBy]
type = NotHitBy
triggerall = numhelper(4500) && numhelper(2001)
trigger1 = helper(4500), stateno = 2002 || helper(4500),stateno = 2006
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State -2, PlaySnd]
type = PlaySnd
trigger1 = !IsHelper && roundno >= 2 && !var(51)
value = 2500,0
channel = 9
lowpriority = 1
loop = 1
ignorehitpause = 1

[State -2, VarSet]
type = VarSet
trigger1 = roundno >= 2 && !var(51)
v = 51
value = 1
ignorehitpause = 1

[State -2, StopSnd]
type = StopSnd
trigger1 = !IsHelper && numhelper(2001)
trigger1 = helper(2001), stateno = 2008
channel = 9
ignorehitpause = 1

[State 2008, PlaySnd]
type = PlaySnd
trigger1 = !IsHelper && numhelper(2001)
trigger1 = helper(2001), stateno = 2008 && helper(2001), time = 6
value = S2500,1
channel = 10
lowpriority = 1
loop = 1
ignorehitpause = 1

[State -2, StopSnd]
type = StopSnd
trigger1 = !IsHelper && stateno = 5150 && roundno >= 2 && time = 1
channel = 10
ignorehitpause = 1

[State -2, PlaySnd]
type = PlaySnd
trigger1 = !IsHelper && stateno = 5150 && roundno >= 2 && time = 1
value = 2500,2
channel = 9
lowpriority = 1
loop = 1
ignorehitpause = 1

[State -2, AssertSpecial]
type = AssertSpecial
trigger1 = roundno >= 2
flag = nomusic
ignorehitpause = 1

[State -2, SelfState]
type = SelfState
trigger1 = !IsHelper && !Alive && stateno != [5050, 5200]
value = 5050
ctrl = 0

;[State -2, AssertSpecial]
;type = AssertSpecial
;trigger1 = roundno <= 1
;flag = nomusic

[State -2, PlaySnd]
type = PlaySnd
trigger1 = !IsHelper && enemynear, name = "Super Metroid" && (stateno = 216 || stateno = 215) && gametime % 60 = 0
value = S250,0
channel = -1
ignorehitpause = 1

[State -2, PowerAdd]
type = PowerAdd
trigger1 = life <= lifemax/2
value = 1
ignorehitpause = 1

[State 200, AssertSpecial]
type = AssertSpecial
trigger1 = 1
flag = invisible
ignorehitpause = 1

[State -2, Helper]
type = Helper
trigger1 = numhelper(4500) <= 0 && !IsHelper && Alive
helpertype = normal
name = "Mother Brain - Head"
ID = 4500
stateno = 4500
pos = 0,0
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
ignorehitpause = 1
persistent = 0

[State -2, Helper]
type = Helper
trigger1 = numhelper(50) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Corpo"
ID = 50
stateno = 3000
pos = 0,0
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)
ignorehitpause = 1
persistent = 0

[State -2, Helper]
type = Helper
trigger1 = numhelper(2000) <= 0 && !IsHelper && Alive
helpertype = normal
name = "Contorno"
ID = 2000
stateno = 2000
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(500) <= 0 && !IsHelper && Alive
helpertype = normal
name = "Olho"
ID = 500
stateno = 500
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(600) <= 0 && !IsHelper && Alive
helpertype = normal
name = "Boca"
ID = 600
stateno = 600
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

;[State -2, Explod]
;type = Explod
;trigger1 = numexplod(1) < 1
;anim = 1
;ID = 1
;pos = 0,0
;postype = p1  ;p2,front,back,left,right
;facing = 1
;vfacing = 1
;bindtime = -1
;vel = 0,0
;accel = 0,0
;random = 0,0
;removetime = -1
;scale = 1,1
;sprpriority = -1
;ontop = 0
;shadow = -1,-1,-1
;ownpal = 0
;removeongethit = 0
;ignorehitpause = 1
;persistent = 0

[State -2, Helper]
type = Helper
trigger1 = !var(1) && numhelper(1000) <= 0 && !IsHelper && roundno = 1
helpertype = normal
name = "Plataforma"
ID = 1000
stateno = 1000
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
;size.xscale (float)
;size.yscale (float)
size.ground.back = floor(47*Const(size.xscale))
size.ground.front = floor(49*Const(size.yscale))
size.air.back = floor(47*Const(size.xscale))
size.air.front = floor(49*Const(size.yscale))
size.height = floor(300*Const(size.yscale))
;size.proj.doscale (int)
;size.head.pos (int,int)
;size.mid.pos (int,int)
;size.shadowoffset (int)

[State -2, Helper]
type = Helper
trigger1 = !var(1) && numhelper(1000) > 0 && numhelper(1001) <= 0 && !IsHelper  && roundno = 1
helpertype = normal
name = "Pote de Vidro"
ID = 1001
stateno = 1001
pos = floor(helper(1000), pos x*Const(size.xscale)),floor(helper(1000), pos y*Const(size.yscale))
;postype = left    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
;size.xscale (float)
;size.yscale (float)
size.ground.back = floor(32*Const(size.xscale))
size.ground.front = floor(32*Const(size.yscale))
size.air.back = floor(32*Const(size.xscale))
size.air.front = floor(32*Const(size.yscale))
size.height = floor(64*Const(size.yscale))
ignorehitpause = 1
persistent = 0

[State -2, Helper]
type = Helper
trigger1 = numhelper(300) <= 0 && !IsHelper && roundno = 1
helpertype = normal
name = "Plataform"
ID = 300
stateno = 300
pos = floor(40*Const(size.xscale)),floor(-50*Const(size.yscale))
facing = 1
keyctrl = 0
ownpal = 1
size.ground.back = floor(15*Const(size.xscale))
size.ground.front = floor(15*Const(size.xscale))
size.air.back = floor(15*Const(size.xscale))
size.air.front = floor(15*Const(size.xscale))
size.height = 0;floor(0*Const(size.yscale))
ignorehitpause = 1
persistent = 0

[State -2, Helper]
type = Helper
trigger1 = numhelper(1006) <= 0 && !IsHelper && roundno = 1
helpertype = normal
name = "Acido"
ID = 1006
stateno = 1006
pos = 0,floor(100*Const(size.yscale))
postype = left
facing = 1
keyctrl = 0
ownpal = 1
ignorehitpause = 1
persistent = 0

[State -2, Helper]
type = Helper
trigger1 = numhelper(10) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Parte do pescoco"
ID = 10
stateno = 900
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(11) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Parte do pescoco"
ID = 11
stateno = 900
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(12) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Parte do pescoco"
ID = 12
stateno = 900
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(13) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Parte do pescoco"
ID = 13
stateno = 900
pos = 0, 0
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1
size.xscale = Const(size.xscale)
size.yscale = Const(size.yscale)

[State -2, Helper]
type = Helper
trigger1 = numhelper(800) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Orientador da cabeca"
ID = 800
stateno = 800
pos = 0, ifelse(roundno = 2, 0, -100)
postype = p1    ;p2,front,back,left,right
facing = 1
keyctrl = 0
ownpal = 1

[State -2, Helper]
type = Helper
trigger1 = numhelper(60) <= 0 && !IsHelper && roundno > 1 && Alive
helpertype = normal
name = "Pernas"
ID = 60
stateno = 4000
pos = floor(-60*Const(size.xscale)),ifelse(roundno = 2, floor(200*Const(size.yscale)), 0)
facing = 1
keyctrl = 0
ownpal = 1
ignorehitpause = 1
persistent = 0

[State -2, VarSet]
type = VarSet
trigger1 = NumHelper(1000) > 0 && NumHelper(1001) > 0 && roundstate = 2
v = 1    ;fv = 10
value = 1
ignorehitpause =  1

[State -2, NotHitBy]
type = NotHitBy
trigger1 = numtarget(704)
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State -2, HitOverride]
type = HitOverride
trigger1 = !IsHelper
attr = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
slot = 0
stateno = 200
time = -1
forceair = 0
ignorehitpause = 1

[State -2, PlayerPush]
type = PlayerPush
trigger1 = !IsHelper
value = 0
ignorehitpause = 1

;[State -2, PosSet]
;type = PosSet
;trigger1 = IsHelper(1001)
;x = Helper(1000), pos x
;y = Helper(1000), pos y
;ignorehitpause = 1

[State -2, SelfState]
type = SelfState
trigger1 = movetype != I && !ISHelper && NumHelper(1000) && time > 30
value = 0
ctrl = 1
movetype = I

[State -2, PosSet]
type = PosSet
trigger1 = !IsHelper && NumHelper(1000) && movetype = I
x = floor(helper(1000), pos x+(1*facing)*Const(size.xscale))
y = floor(helper(1000), pos y-85*Const(size.yscale))
ignorehitpause = 1

[State -2, VelSet]
type = VelSet
trigger1 = !Alive && numhelper(1000) + numhelper(50) > 0 && !var(15)
x = 0
y = 0
ignorehitpause = 1

[State -2, VarSet]
type = VarSet
trigger1 = !Alive
v = 12
value = 1
ignorehitpause = 1

[State -2, VarSet]
type = VarSet
triggerall = !IsHelper
trigger1 = 1;numhelper(1001) > 0
v = 4
value = 0
ignorehitpause = 1

[State -2, SprPriority]
type = SprPriority
trigger1 = !IsHelper
value = -3
ignorehitpause = 1

;[State -2, ScreenBound]
;type = ScreenBound
;trigger1 = !IsHelper
;value = 0
;ignorehitpause = 1

[State -2, LifeSet]
type = LifeSet
trigger1 = NumHelper(1001) > 0
value = lifemax/6
ignorehitpause = 1

[State -2, LifeSet]
type = LifeSet
trigger1 = roundno <= 1 && life > lifemax/6
value = lifemax/6
ignorehitpause = 1

[State -2, Turn]
type = Turn
triggerall = !IsHelper && roundno > 1 && ctrl && numhelper(60)
trigger1 = facing = -1

;[State -2, Turn]
;type = Turn
;triggerall = !IsHelper && roundno > 1 && ctrl && numhelper(60)
;trigger1 = helper(60), P2Dist X < 0

[State -2, AssertSpecial]
type = AssertSpecial
trigger1 = !IsHelper
flag = noautoturn
flag2 = nowalk
flag3 = nostandguard
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
trigger1 = Roundno <= 1 && !IsHelper && !Alive
time = 1
add = 100,100,0
mul = 200,200,200
color = 0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
trigger1 = Roundno >= 2 && !IsHelper && !Alive
time = 1
color = 0
ignorehitpause = 1

;Generated by Fighter Factory PalFX Editor
[State -2, PalFXWiz]
type = PalFX
triggerall = !IsHelper && alive
trigger1 = enemynear, name = "Super Metroid" && (stateno = 216 || stateno = 215)
trigger2 = stateno = 2002 && life >= lifemax/8 && life < lifemax/2
time = 1
add = 0,0,128
mul = 256,256,256
sinadd = 0,0,0,1
invertall = 0
color = 256
ignorehitpause = 1

[State -3, DisplayToClipboard]
type = AppendToClipboard
trigger1 = 1
text = " -2"
ignorehitpause = 1

[Statedef -3]

[State -3, TargetFacing]
type = TargetFacing
triggerall = numhelper(4500)
trigger1 = helper(4500), stateno = 704 && numtarget
value = -1
ignorehitpause = 1

[State -3, DisplayToClipboard]
type = DisplayToClipboard
trigger1 = 1
text = "-3"
ignorehitpause = 1

[State -3, TargetState]
type = TargetState
triggerall = numhelper(4500)
trigger1 = numtarget(704) && helper(4500), stateno = 4500 && roundstate = 2 && alive
value = 15964
ignorehitpause = 1

[State -3, TargetPowerAdd]
type = TargetPowerAdd
triggerall = numhelper(4500)
trigger1 = helper(4500), var(54) && numtarget = 1
value = target, PowerMax
ignorehitpause = 1

[State -3, AttackMulSet]
type = AttackMulSet
triggerall = numhelper(4500)
trigger1 = helper(4500), var(54)
time = 1
value = 0.5
ignorehitpause = 1

[State -3, ChangeAnim]
type = ChangeAnim
triggerall = numhelper(4500)
trigger1 = !IsHelper && helper(4500), var(54) && anim != 15
value = 15
ignorehitpause = 1

[State -3, PosSet]
type = PosSet
trigger1 = Pos Y > 0 && alive
y = 0

[State -3, NotHitBy]
type = NotHitBy
triggerall = numhelper(60)
trigger1 = helper(60), Pos Y > 0
value = SCA,NA,SA,HA,NP,SP,HP,NT,ST,HT
time = 1
ignorehitpause = 1

[State -3, CtrlSet]
type = CtrlSet
triggerall = !IsHelper && roundno > 1 && ctrl && numhelper(800) && numhelper(60)
trigger1 = helper(800), pos x > helper(60), pos x && facing = -1
trigger2 = helper(800), pos x < helper(60), pos x && facing = 1
trigger3 = helper(60), Pos Y > 0
value = 0
ignorehitpause = 1

[State -3, CtrlSet]
type = CtrlSet
triggerall = !IsHelper && roundno > 1 && !ctrl && numhelper(800) && numhelper(60) && stateno = 0
triggerall = helper(60), Pos Y <= 0
trigger1 = helper(800), pos x < helper(60), pos x && facing = -1
trigger2 = helper(800), pos x > helper(60), pos x && facing = 1
value = 1
ignorehitpause = 1

[State 200, VarSet]
type = VarSet
trigger1 = var(11) && stateno != 200
v = 11
value = 0
ignorehitpause =  1

[State -2, ScreenBound]
type = ScreenBound
trigger1 = !IsHelper && stateno != 704
value = 0
ignorehitpause = 1

[State -3, ChangeState]
type = ChangeState
trigger1 = numhelper(2001) && alive
trigger1 = !IsHelper && helper(2001), var(0) && helper(2001), stateno = 2001 && stateno != 2010 && stateno != 200
value = 2010
ctrl = 0
ignorehitpause = 1

[State -3, ChangeState]
type = ChangeState
trigger1 = var(14) && ctrl
value = 704
ctrl = 0
ignorehitpause = 1

[State -3, Explod]
type = Explod
triggerall = numhelper(4500) && gametime % 90 = 0 && roundno > 1 && Alive && roundstate = 2
trigger1 = helper(4500), stateno != 2002 && helper(4500), stateno != 2006 && helper(4500), ctrl
trigger2 = (helper(4500), stateno = 2006 && helper(4500), time >= 120)
anim = 4
ID = 4
pos = floor(5),floor(-4)
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
vel = 0,0
accel = 0,0
random = 0,0
removetime = -2
sprpriority = 4
ownpal = 1
removeongethit = 0
ignorehitpause = 1

[State -3, PosSet]
type = PosAdd
trigger1 = !IsHelper && numhelper(800) > 0 && roundstate >= 2
x = ((helper(800), pos x - pos x)*facing)/4
y = (helper(800), pos y - pos y)/4
ignorehitpause = 1

[State -3, Explod]
type = Explod
trigger1 = time < 60 && !(time % 10) && stateno = 200 && roundno > 1
anim = 7
ID = 7
pos = 0,0
postype = p1  ;p2,front,back,left,right
facing = 1
vfacing = 1
bindtime = 1
removetime = -2
sprpriority = 3
shadow = -1,-1,-1
ownpal = 1
ignorehitpause = 1

[State -3, PosSet]
type = PosSet
trigger1 = !IsHelper && numhelper(800) > 0 && roundstate < 2 && roundno > 2
x = helper(800), pos x
y = helper(800), pos y
ignorehitpause = 1

; WINANE AI
[State -3, TurnBackOnAI]
type = VarSet
trigger1 = var(58) = -2 && !IsHelper
trigger1 = Alive && RoundState = 2
var(58) = 1

[State -3, XOR]
type = VarSet
triggerall = var(58)!=1 && !IsHelper
triggerall = !var(56)
triggerall = var(57) = GameTime-1
trigger1 = command = "a" ^^ command = "a2"
trigger2 = command = "b" ^^ command = "b2"
trigger3 = command = "c" ^^ command = "c2"
trigger4 = command = "x" ^^ command = "x2"
trigger5 = command = "y" ^^ command = "y2"
trigger6 = command = "z" ^^ command = "z2"
trigger7 = command = "start" ^^ command = "start2"
trigger8 = command = "holda" ^^ command = "holda2"
trigger9 = command = "holdb" ^^ command = "holdb2"
trigger10 = command = "holdc" ^^ command = "holdc2"
trigger11 = command = "holdx" ^^ command = "holdx2"
trigger12 = command = "holdy" ^^ command = "holdy2"
trigger13 = command = "holdz" ^^ command = "holdz2"
trigger14 = command = "holdstart" ^^ command = "holdstart2"
trigger15 = command = "holdfwd" ^^ command = "holdfwd2"
trigger16 = command = "holdback" ^^ command = "holdback2"
trigger17 = command = "holdup" ^^ command = "holdup2"
trigger18 = command = "holddown" ^^ command = "holddown2"
trigger19 = command = "recovery" ^^ command = "recovery2"
var(58) = 1

[State -3, fiXOR]
type = VarAdd
trigger1 = var(56) > 0 && !IsHelper
var(56) = -1

[State -3, fuXOR]
type = VarSet
trigger1 = var(57) < GameTime-1 && !IsHelper
var(56) = 31
IgnoreHitPause = 1

[State -3, GameTimeVar]
type = VarSet
trigger1 = !IsHelper
var(57) = GameTime
IgnoreHitPause = 1

; Within StateDef -3, none of your own AI-related code should come after the code
; provided here (and putting it before the code is also generally a bad idea).
; It's better to use State -1 (or, in special circumstances, State -2) instead.


;-------------- Generated by Fighter Factory -------------

;--------------------- Variable List ----------------------


;--------------------- Float Variable List ----------------------

