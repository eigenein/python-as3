package game.view.popup.test
{
   import avmplus.getQualifiedClassName;
   import battle.BattleEngine;
   import battle.BattleLog;
   import battle.data.BattleData;
   import battle.data.BattleHeroDescription;
   import battle.timeline.Timeline;
   import flash.events.Event;
   import flash.net.URLLoader;
   import flash.net.URLRequest;
   import game.assets.battle.BattleCodeAsset;
   import game.assets.storage.AssetStorage;
   import game.battle.BattleDataFactory;
   import game.battle.RandomSequence;
   import game.data.storage.DataStorage;
   import game.mediator.gui.popup.PopupMediator;
   import game.model.user.Player;
   import game.view.popup.PopupBase;
   import idv.cjcat.signals.Signal;
   import starling.animation.IAnimatable;
   import starling.core.Starling;
   
   public class BattleTestVerificationPopupMediator extends PopupMediator implements IAnimatable
   {
      
      public static const BATCH_SIZE:int = 10;
      
      public static const BATTLES_PER_FRAME:int = 10;
      
      protected static var preselectedHeroes:Vector.<int> = new Vector.<int>(0);
      
      protected static var heroes:Vector.<int> = new <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,29,30,31,32,33,34];
      
      protected static var enemyHeroes:Vector.<int> = new <int>[1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,25,26,27,28,29,30,31,32,33,34];
       
      
      public const onStartButtonToggled:Signal = new Signal();
      
      public const onCountUpdated:Signal = new Signal();
      
      protected var enabled:Boolean;
      
      protected var _count:int;
      
      protected var _failCount:int;
      
      protected var requestCompleted:Boolean;
      
      protected var factory:BattleDataFactory;
      
      protected var currentBattle:BattleTestEntry;
      
      protected var queue:Vector.<BattleTestEntry>;
      
      protected var currentBatch:Vector.<BattleTestEntry>;
      
      protected var battleHeroes:Vector.<BattleHeroDescription>;
      
      public function BattleTestVerificationPopupMediator(param1:Player)
      {
         super(param1);
         enabled = false;
         _failCount = 0;
         _count = 0;
         battleHeroes = new Vector.<BattleHeroDescription>();
         factory = new BattleDataFactory();
         queue = new Vector.<BattleTestEntry>(0);
         requestCompleted = true;
         BattleLog.doLog = true;
         AssetStorage.battle.requestAllCode();
         AssetStorage.instance.globalLoader.tryComplete(startTest);
      }
      
      private function startTest(param1:*) : void
      {
         addTest("12593727","{\"defenders\":{\"heroes\":[{\"state\":{\"energy\":723,\"isDead\":false,\"hp\":495697},\"element\":null,\"skin\":0,\"heroId\":42,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.78,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":75,\"area\":100,\"cooldown\":5.2,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Melee\",\"level\":0}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.9,\"prime\":{\"scale\":2000,\"type\":\"magic\",\"c\":0,\"K\":1.1,\"base\":\"MP\"},\"range\":590,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"FattyUlt\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.56,\"prime\":{\"scale\":150,\"type\":\"dot\",\"c\":0,\"K\":0.4,\"base\":\"MP\"},\"cooldown\":15,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"FattyProjectileDot\",\"projectile\":{\"x\":163,\"speed\":400,\"y\":-137},\"duration\":4,\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0,\"prime\":{\"scale\":0.5,\"c\":0,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":3,\"calculatedParams\":{\"h\":{\"tier\":1}},\"behavior\":\"ValueSkillModifier\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0,\"prime\":{\"scale\":1500,\"c\":-55000,\"K\":5,\"base\":\"MP\"},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PassiveSelfEffect\",\"effect\":\"FattyPassive\",\"duration\":0.8,\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"armor\",\"duration\":9,\"level\":1}}],\"battleOrder\":6,\"name\":\"Руфус\",\"id\":4,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":4035,\"magicResist\":5625,\"intelligence\":2618,\"physicalAttack\":50,\"hp\":153499,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"strength\",\"strength\":9520,\"agility\":1584,\"accuracy\":0,\"anticrit\":0,\"magicPower\":33297}},{\"state\":{\"energy\":111,\"isDead\":false,\"hp\":37915},\"element\":null,\"skin\":0,\"heroId\":41,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.46,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":100,\"area\":47,\"cooldown\":5.2,\"tier\":0,\"calculatedParams\":{\"h\":{\"fxOffset\":0}},\"behavior\":\"MeleeWithFx\",\"level\":0}},{\"h\":{\"hitrate\":1,\"animationDelay\":0.5,\"range\":590,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"OctoUlt\",\"duration\":2,\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0.05,\"c\":9,\"K\":1,\"base\":null},\"animationDelay\":0.5,\"prime\":{\"scale\":0.2,\"c\":26,\"K\":1,\"base\":null},\"cooldown\":18,\"tier\":2,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"OctoShield\",\"duration\":8,\"level\":130}},{\"h\":{\"hitrate\":1,\"animationDelay\":0,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"cooldown\":0,\"tier\":3,\"calculatedParams\":{\"h\":{}},\"behavior\":\"OctoPassive\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0,\"prime\":{\"scale\":0.25,\"c\":-5,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{\"tier\":3}},\"behavior\":\"ValueSkillModifier\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":21357,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"physicalAttack\",\"duration\":9,\"level\":1}}],\"battleOrder\":10,\"name\":\"К\'арх\",\"id\":2,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":4330,\"magicResist\":562,\"intelligence\":1676,\"physicalAttack\":14429,\"hp\":61756,\"lifesteal\":0,\"armorPenetration\":27420,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"agility\",\"strength\":2249,\"agility\":9430,\"accuracy\":0,\"anticrit\":0,\"magicPower\":0}},{\"state\":{\"energy\":876,\"isDead\":false,\"hp\":139425},\"element\":null,\"skin\":0,\"heroId\":21,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.46,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":100,\"area\":47,\"cooldown\":5.4,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Melee\",\"level\":0}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.85,\"prime\":{\"scale\":50,\"c\":0,\"K\":0.05,\"base\":\"MP\"},\"range\":375,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"UltPaladin\",\"duration\":5,\"level\":130}},{\"h\":{\"secondary\":{\"scale\":35,\"c\":0,\"K\":0.15,\"base\":\"MP\"},\"animationDelay\":1,\"prime\":{\"scale\":35,\"type\":\"magic\",\"c\":0,\"K\":0.15,\"base\":\"MP\"},\"range\":375,\"cooldown\":13,\"tier\":2,\"hitrate\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PaladinWave\",\"projectile\":{\"x\":123,\"speed\":600,\"y\":-115},\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.66,\"prime\":{\"scale\":100,\"c\":-2000,\"K\":0.25,\"base\":\"MP\"},\"cooldown\":18,\"tier\":3,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PaladinHeal\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.8,\"prime\":{\"scale\":0.4,\"c\":-6,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PaladinPassive\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":21357,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"physicalAttack\",\"duration\":9,\"level\":1}}],\"battleOrder\":11,\"name\":\"Маркус\",\"id\":3,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":24915,\"magicResist\":11099,\"intelligence\":8665,\"physicalAttack\":3923,\"hp\":183711,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"intelligence\",\"strength\":2231,\"agility\":1966,\"accuracy\":0,\"anticrit\":0,\"magicPower\":13496}},{\"state\":{\"energy\":306,\"isDead\":false,\"hp\":25738},\"element\":null,\"skin\":0,\"heroId\":15,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.58,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":300,\"cooldown\":5,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PirateAutoAttack\",\"projectile\":{\"x\":147,\"speed\":650,\"y\":-73},\"level\":0}},{\"h\":{\"hitrate\":0,\"animationDelay\":1,\"prime\":{\"scale\":20,\"type\":\"physical\",\"c\":0,\"K\":0.1,\"base\":\"PA\"},\"range\":320,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{\"delay\":0.3}},\"behavior\":\"UltPirate\",\"projectile\":{\"x\":0,\"speed\":2100,\"y\":0},\"hits\":7,\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.6,\"prime\":{\"scale\":65,\"type\":\"physical\",\"c\":0,\"K\":0.6,\"base\":\"PA\"},\"range\":320,\"cooldown\":13.5,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PiratePiercingShoot\",\"projectile\":{\"x\":138,\"speed\":300,\"y\":-74},\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":1.4,\"prime\":{\"scale\":45,\"type\":\"physical\",\"c\":-700,\"K\":0.2,\"base\":\"PA\"},\"range\":320,\"cooldown\":19,\"tier\":3,\"calculatedParams\":{\"h\":{\"delay\":0.1}},\"behavior\":\"PirateBuckshot\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0,\"prime\":{\"scale\":100,\"type\":\"physical\",\"c\":-4000,\"K\":1.4,\"base\":\"PA\"},\"range\":320,\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{\"maxStacks\":5,\"tier\":0}},\"behavior\":\"PirateAutoAttackModifier\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":21357,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"physicalAttack\",\"duration\":9,\"level\":1}}],\"battleOrder\":2003,\"name\":\"Джинджер\",\"id\":0,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":0,\"magicResist\":5366,\"intelligence\":1973,\"physicalAttack\":26109,\"hp\":47300,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":5882,\"magicPenetration\":0,\"mainStat\":\"agility\",\"strength\":2228,\"agility\":9323,\"accuracy\":0,\"anticrit\":0,\"magicPower\":0}},{\"state\":{\"energy\":511,\"isDead\":false,\"hp\":162552},\"element\":null,\"skin\":0,\"heroId\":30,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.51,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"MP\"},\"range\":350,\"cooldown\":4.65,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ProjectileWithWeapon\",\"projectile\":{\"x\":148,\"speed\":600,\"y\":-174},\"level\":0}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.4,\"prime\":{\"scale\":20,\"type\":\"physical\",\"c\":0,\"K\":0.1,\"base\":\"MP\"},\"range\":590,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"AntimageUlt\",\"projectile\":{\"x\":14,\"speed\":350,\"y\":-335},\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":1,\"prime\":{\"scale\":75,\"c\":0,\"K\":0.4,\"base\":\"MP\"},\"cooldown\":12,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"AntimageDebuff\",\"duration\":12,\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.6,\"prime\":{\"scale\":30,\"c\":500,\"K\":0.25,\"base\":\"MP\"},\"range\":350,\"cooldown\":15,\"tier\":3,\"calculatedParams\":{\"h\":{}},\"behavior\":\"AntimageBuff\",\"duration\":6,\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.5,\"prime\":{\"scale\":1,\"c\":-30,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{}},\"behavior\":\"AntimagePassive\",\"duration\":-1,\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"magicResist\",\"duration\":9,\"level\":1}}],\"battleOrder\":2007,\"name\":\"Корнелиус\",\"id\":1,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":4941,\"magicResist\":5904,\"intelligence\":9945,\"physicalAttack\":134,\"hp\":244834,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"intelligence\",\"strength\":1946,\"agility\":1941,\"accuracy\":0,\"anticrit\":0,\"magicPower\":22625}}],\"input\":[]},\"b\":0,\"seed\":12593727,\"v\":141,\"attackers\":{\"heroes\":[{\"state\":{\"energy\":346,\"isDead\":false,\"hp\":342653},\"element\":null,\"skin\":0,\"heroId\":27,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.33,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":50,\"area\":100,\"cooldown\":5.5,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Melee\",\"level\":0}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.93,\"prime\":{\"scale\":50,\"type\":\"physical\",\"c\":0,\"K\":0.1,\"base\":\"PA\"},\"range\":590,\"area\":90,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"PaladinWarriorUlt\",\"level\":130}},{\"h\":{\"animationDelay\":1.16,\"range\":50,\"area\":200,\"tier\":2,\"hitrate\":1,\"prime\":{\"scale\":50,\"type\":\"physical\",\"c\":0,\"K\":0.3,\"base\":\"PA\"},\"level\":130,\"behavior\":\"PaladinWarriorStun\",\"effect\":\"stun\",\"cooldown\":15,\"duration\":1,\"calculatedParams\":{\"h\":{}}}},{\"h\":{\"hitrate\":1,\"animationDelay\":0,\"prime\":{\"scale\":25,\"type\":\"physical\",\"c\":0,\"K\":0.2,\"base\":\"PA\"},\"area\":180,\"cooldown\":0,\"tier\":3,\"calculatedParams\":{\"h\":{\"tier\":1}},\"behavior\":\"ValueSkillModifier\",\"effect\":\"stun\",\"duration\":2,\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0,\"prime\":{\"scale\":10,\"c\":-200,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{\"statName\":\"magicResist\"}},\"behavior\":\"PassiveSelfBuff\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"armor\",\"duration\":9,\"level\":1}}],\"battleOrder\":4,\"name\":\"Лютер\",\"id\":3,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":15297,\"magicResist\":12902,\"intelligence\":2140,\"physicalAttack\":15403,\"hp\":79046,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"strength\",\"strength\":8962,\"agility\":2405,\"accuracy\":0,\"anticrit\":0,\"magicPower\":0}},{\"state\":{\"energy\":657,\"isDead\":false,\"hp\":788144},\"element\":null,\"skin\":0,\"heroId\":26,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.28,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":100,\"cooldown\":5,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Projectile\",\"projectile\":{\"x\":97,\"speed\":600,\"y\":-144},\"level\":0}},{\"h\":{\"hitrate\":1,\"animationDelay\":0.43,\"prime\":{\"scale\":50,\"type\":\"magic\",\"c\":0,\"K\":0.2,\"base\":\"MP\"},\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Hero26Ult\",\"effect\":\"stun\",\"duration\":1,\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.5,\"prime\":{\"scale\":50,\"type\":\"magic\",\"c\":0,\"K\":0.15,\"base\":\"MP\"},\"range\":250,\"area\":50,\"cooldown\":14,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Melee\",\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.42,\"prime\":{\"scale\":75,\"type\":\"magic\",\"c\":0,\"K\":0.2,\"base\":\"MP\"},\"range\":500,\"cooldown\":20,\"tier\":3,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Hero26Punch\",\"effect\":\"knockback(110,0.15)\",\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.5,\"prime\":{\"scale\":0.3,\"c\":-4,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{\"tier\":3}},\"behavior\":\"ValueSkillModifier\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"magicResist\",\"duration\":9,\"level\":1}}],\"battleOrder\":13,\"name\":\"Лилит\",\"id\":4,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":15594,\"magicResist\":1330,\"intelligence\":2180,\"physicalAttack\":1780,\"hp\":75171,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":16840,\"mainStat\":\"strength\",\"strength\":9149,\"agility\":1795,\"accuracy\":0,\"anticrit\":0,\"magicPower\":28456}},{\"state\":{\"energy\":121,\"isDead\":false,\"hp\":210690},\"element\":null,\"skin\":0,\"heroId\":36,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.68,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":175,\"area\":100,\"cooldown\":5.5,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Projectile\",\"projectile\":{\"x\":108,\"speed\":600,\"y\":-108},\"level\":0}},{\"h\":{\"secondary\":{\"scale\":200,\"c\":0,\"K\":1,\"base\":\"MP\"},\"animationDelay\":0.73,\"prime\":{\"scale\":10,\"c\":0,\"K\":0.03,\"base\":\"MP\"},\"range\":175,\"cooldown\":0,\"tier\":1,\"hitrate\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"FloweyUlt\",\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.61,\"prime\":{\"scale\":100,\"type\":\"dot\",\"c\":0,\"K\":0.25,\"base\":\"MP\"},\"cooldown\":12,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"FloweyPoison\",\"duration\":6,\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.8,\"prime\":{\"scale\":100,\"type\":\"dot\",\"c\":0,\"K\":0.25,\"base\":\"MP\"},\"area\":180,\"cooldown\":20,\"tier\":3,\"calculatedParams\":{\"h\":{}},\"behavior\":\"FloweyVines\",\"duration\":6,\"level\":130}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0,\"prime\":{\"scale\":400,\"type\":\"dot\",\"c\":0,\"K\":1,\"base\":\"MP\"},\"area\":350,\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{\"tier\":1}},\"behavior\":\"ValueSkillModifier\",\"duration\":8,\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"magicResist\",\"duration\":9,\"level\":1}}],\"battleOrder\":1001,\"name\":\"Майя\",\"id\":0,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":3360,\"magicResist\":7788,\"intelligence\":9812,\"physicalAttack\":50,\"hp\":129090,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"intelligence\",\"strength\":2040,\"agility\":1645,\"accuracy\":0,\"anticrit\":0,\"magicPower\":46246}},{\"state\":{\"energy\":200,\"isDead\":false,\"hp\":277868},\"element\":null,\"skin\":0,\"heroId\":29,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.51,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":375,\"area\":47,\"cooldown\":4.5,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Projectile\",\"projectile\":{\"x\":86,\"speed\":700,\"y\":-101},\"level\":0}},{\"h\":{\"hitrate\":-1,\"animationDelay\":0.61,\"prime\":{\"scale\":1,\"c\":25,\"K\":1,\"base\":null},\"range\":590,\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"VampireUlt\",\"projectile\":{\"x\":80,\"speed\":1000,\"y\":-75},\"duration\":7,\"level\":130}},{\"h\":{\"cooldownInitial\":18,\"animationDelay\":0.6,\"prime\":{\"scale\":0,\"c\":20,\"K\":1,\"base\":null},\"calculatedParams\":{\"h\":{}},\"cooldown\":12,\"tier\":2,\"hitrate\":0,\"secondary\":{\"scale\":0.5,\"c\":100,\"K\":1,\"base\":null},\"behavior\":\"VampireHeal\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":1,\"base\":null},\"animationDelay\":0.53,\"prime\":{\"scale\":30,\"type\":\"magic\",\"c\":500,\"K\":0.11,\"base\":\"MP\"},\"range\":375,\"cooldown\":19,\"tier\":3,\"hitrate\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"VampireWave\",\"projectile\":{\"x\":0,\"speed\":1000,\"y\":0},\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.5,\"prime\":{\"scale\":1,\"c\":-15,\"K\":1,\"base\":null},\"area\":130,\"cooldown\":0,\"tier\":4,\"calculatedParams\":{\"h\":{}},\"behavior\":\"VampireAura\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":21357,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"physicalAttack\",\"duration\":9,\"level\":1}}],\"battleOrder\":2013,\"name\":\"Дориан\",\"id\":1,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":4449,\"magicResist\":4587,\"intelligence\":9401,\"physicalAttack\":106,\"hp\":257870,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"intelligence\",\"strength\":2162,\"agility\":2027,\"accuracy\":0,\"anticrit\":0,\"magicPower\":34595}},{\"state\":{\"energy\":789,\"isDead\":false,\"hp\":174443},\"element\":null,\"skin\":0,\"heroId\":7,\"scale\":1,\"level\":130,\"skills\":[{\"h\":{\"hitrate\":0,\"animationDelay\":0.66,\"prime\":{\"scale\":0,\"type\":\"physical\",\"c\":0,\"K\":1,\"base\":\"PA\"},\"range\":400,\"cooldown\":4.8,\"tier\":0,\"calculatedParams\":{\"h\":{}},\"behavior\":\"Ray\",\"level\":0}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.66,\"prime\":{\"scale\":50,\"c\":200,\"K\":0.3,\"base\":\"MP\"},\"cooldown\":0,\"tier\":1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"UltSunSupport\",\"level\":130}},{\"h\":{\"hitrate\":0,\"animationDelay\":0.66,\"prime\":{\"scale\":70,\"c\":0,\"K\":0.4,\"base\":\"MP\"},\"cooldown\":13,\"tier\":2,\"calculatedParams\":{\"h\":{}},\"behavior\":\"SunSupportHealOne\",\"level\":130}},{\"h\":{\"animationDelay\":0.1,\"range\":400,\"area\":175,\"tier\":3,\"hitrate\":1,\"prime\":{\"scale\":15,\"type\":\"magic\",\"c\":0,\"K\":0.1,\"base\":\"MP\"},\"level\":130,\"behavior\":\"SunSupportAoe\",\"effect\":\"silence\",\"cooldown\":21,\"duration\":3,\"calculatedParams\":{\"h\":{\"delay\":0.67}}}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":30,\"K\":1,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0.5,\"c\":-10,\"K\":1,\"base\":null},\"cooldown\":0,\"tier\":4,\"hitrate\":0,\"calculatedParams\":{\"h\":{\"hpLeftLimit\":0.3}},\"behavior\":\"SunSupportPassive\",\"level\":130}},{\"h\":{\"secondary\":{\"scale\":0,\"c\":100,\"K\":0,\"base\":null},\"animationDelay\":0,\"prime\":{\"scale\":0,\"c\":32040,\"K\":0,\"base\":null},\"cooldown\":0,\"tier\":6,\"hitrate\":-1,\"calculatedParams\":{\"h\":{}},\"behavior\":\"ArtifactStat\",\"effect\":\"magicResist\",\"duration\":9,\"level\":1}}],\"battleOrder\":2016,\"name\":\"Тея\",\"id\":2,\"stats\":{\"dodge\":0,\"antidodge\":0,\"armor\":4982,\"magicResist\":7951,\"intelligence\":9287,\"physicalAttack\":78,\"hp\":129591,\"lifesteal\":0,\"armorPenetration\":0,\"physicalCritChance\":0,\"magicPenetration\":0,\"mainStat\":\"intelligence\",\"strength\":2080,\"agility\":2059,\"accuracy\":0,\"anticrit\":0,\"magicPower\":44750}}],\"input\":[]}}","{\"defenders\":{\"heroes\":{\"0\":{\"energy\":306,\"isDead\":false,\"hp\":25738},\"1\":{\"energy\":511,\"isDead\":false,\"hp\":162552},\"2\":{\"energy\":111,\"isDead\":false,\"hp\":37915},\"3\":{\"energy\":876,\"isDead\":false,\"hp\":139425},\"4\":{\"energy\":723,\"isDead\":false,\"hp\":495697}},\"input\":[]},\"b\":0,\"seed\":12593727,\"v\":141,\"attackers\":{\"heroes\":{\"0\":{\"energy\":121,\"isDead\":false,\"hp\":210690},\"1\":{\"energy\":200,\"isDead\":false,\"hp\":277868},\"2\":{\"energy\":789,\"isDead\":false,\"hp\":174443},\"3\":{\"energy\":346,\"isDead\":false,\"hp\":342653},\"4\":{\"energy\":657,\"isDead\":false,\"hp\":788144}},\"input\":[]}}");
      }
      
      override protected function dispose() : void
      {
         if(enabled)
         {
            action_toggle();
         }
         super.dispose();
      }
      
      public function get startButtonEnabled() : Boolean
      {
         return enabled;
      }
      
      public function get count() : int
      {
         return _count;
      }
      
      public function get failCount() : int
      {
         return _failCount;
      }
      
      public function action_toggle() : void
      {
         enabled = !enabled;
         if(enabled)
         {
            Starling.juggler.add(this);
         }
         else
         {
            Starling.juggler.remove(this);
         }
         onStartButtonToggled.dispatch();
      }
      
      public function advanceTime(param1:Number) : void
      {
         runServerValidationTest();
      }
      
      override public function createPopup() : PopupBase
      {
         _popup = new BattleTestVerificationPopup(this);
         return _popup;
      }
      
      public function addTest(param1:String, param2:String, param3:String) : BattleData
      {
         seed = param1;
         rawDescString = param2;
         rawResultString = param3;
         var rawDesc:* = JSON.parse(rawDescString);
         if(rawResultString)
         {
            var rawResult:* = JSON.parse(rawResultString);
         }
         var battleData:BattleData = new BattleData();
         battleData.parseRawDescription(rawDesc);
         if(rawResult)
         {
            battleData.parseRawResult(rawResult);
         }
         battleData.attackers.initialize(AssetStorage.battle.skillFactory);
         battleData.defenders.initialize(AssetStorage.battle.skillFactory);
         var randomSource:RandomSequence = new RandomSequence(battleData.seed);
         var egn:BattleEngine = new BattleEngine();
         egn.load(battleData,DataStorage.battleConfig.pve,AssetStorage.battle.effectFactory,randomSource.generateInt);
         var ended:Boolean = false;
         egn.onTeamEmpty.add(function(param1:*):*
         {
            ended = true;
         });
         egn.replay();
         egn.finishBattleSeries();
         trace(battleData.isValid());
         var s:String = BattleLog.getLog();
         trace(s);
         return battleData;
      }
      
      protected function get attackerId() : int
      {
         return heroes[int(Math.random() * heroes.length)];
      }
      
      protected function get defenderId() : int
      {
         return enemyHeroes[int(Math.random() * enemyHeroes.length)];
      }
      
      private function runServerValidationTest() : void
      {
         var _loc2_:int = 0;
         var _loc3_:* = null;
         var _loc1_:* = null;
         var _loc4_:* = null;
         if(queue.length < 10)
         {
            factory.clear();
            _loc2_ = 0;
            while(_loc2_ < preselectedHeroes.length)
            {
               factory.addHeroByColor(true,preselectedHeroes[_loc2_],81,10,3,20,0);
               _loc2_++;
            }
            _loc2_ = Math.random() * 4;
            while(_loc2_ < 5 - preselectedHeroes.length)
            {
               factory.addHeroByColor(true,attackerId,81,10,3,20,0);
               _loc2_++;
            }
            _loc2_ = Math.random() * 4;
            while(_loc2_ < 5)
            {
               factory.addHeroByColor(false,defenderId,81,10,3,20,0);
               _loc2_++;
            }
            _loc3_ = new BattleCodeAsset(factory.battleData);
            _loc3_.battleData.attackers.sortByOrder();
            _loc3_.battleData.defenders.sortByOrder();
            AssetStorage.instance.globalLoader.requestAssetWithCallback(_loc3_,startBattle);
         }
         else if(requestCompleted)
         {
            trace("request sent");
            currentBatch = queue.concat();
            queue.length = 0;
            requestCompleted = false;
            _loc1_ = new URLRequest("http://www2.ln/~d.skvortsov/index.php?action=batchValidate");
            _loc1_.method = "POST";
            _loc1_.data = JSON.stringify(currentBatch);
            _loc4_ = new URLLoader();
            _loc4_.addEventListener("complete",onRequestComplete);
            _loc4_.addEventListener("ioError",onIOError);
            _loc4_.load(_loc1_);
         }
      }
      
      private function startBattle(param1:BattleCodeAsset) : void
      {
         var _loc5_:* = NaN;
         var _loc8_:int = 0;
         var _loc7_:int = 0;
         var _loc6_:BattleEngine = new BattleEngine();
         var _loc3_:BattleData = param1.battleData;
         var _loc2_:RandomSequence = new RandomSequence();
         currentBattle = new BattleTestEntry();
         currentBattle.seed = _loc3_.seed;
         currentBattle.desc = JSON.stringify(_loc3_.serialize());
         _loc2_.seed = _loc3_.seed;
         _loc3_.attackers.setUserInput(true);
         _loc6_.load(_loc3_,DataStorage.battleConfig.pve,AssetStorage.battle.effectFactory,_loc2_.generateInt);
         var _loc4_:* = 3;
         _loc5_ = 0;
         while(_loc5_ < 55)
         {
            _loc6_.advanceTime(_loc4_);
            if(!_loc6_.data.isOver())
            {
               _loc8_ = _loc6_.objects.teams[0].heroes.length;
               _loc7_ = 0;
               while(_loc7_ < _loc8_)
               {
                  _loc6_.objects.teams[0].heroes[_loc7_].getVisualDirection();
                  _loc6_.objects.teams[0].heroes[_loc7_].getVisualPosition();
                  if(Math.random() < 0.3)
                  {
                     _loc6_.objects.teams[0].heroes[_loc7_].actionUserInput();
                  }
                  _loc7_++;
               }
               _loc5_ = Number(_loc5_ + _loc4_);
               continue;
            }
            break;
         }
         if(!_loc6_.data.isOver())
         {
            _loc6_.advanceTime(Timeline.INFINITY_TIME);
         }
         currentBattle.log = BattleLog.getLog();
         _loc6_.finishBattleSeries();
         if(!_loc3_.isOver())
         {
            return;
            §§push(trace("! battleData isOver"));
         }
         else
         {
            currentBattle.result = JSON.stringify(_loc3_.serializeResult());
            queue.push(currentBattle);
            _count = Number(_count) + 1;
            onCountUpdated.dispatch();
            return;
         }
      }
      
      private function battleTraceMethod(... rest) : void
      {
      }
      
      private function initBattleHeroes() : void
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      private function onIOError(param1:Event) : void
      {
      }
      
      private function onRequestComplete(param1:Event) : void
      {
         var _loc2_:* = null;
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc3_:* = null;
         requestCompleted = true;
         try
         {
            _loc2_ = JSON.parse((param1.target as Object).data) as Array;
         }
         catch(e:*)
         {
            _loc4_ = currentBatch.length;
            trace("possible infiniteBattle server");
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               trace(currentBatch[_loc5_].testString);
               _loc5_++;
            }
            currentBatch.length = 0;
            try
            {
               trace(e.target.data);
            }
            catch(error:*)
            {
               trace("WUT?! " + error);
            }
         }
         if(_loc2_)
         {
            _loc4_ = _loc2_.length;
            if(_loc4_ > currentBatch.length)
            {
               _loc4_ = currentBatch.length;
            }
            _loc5_ = 0;
            while(_loc5_ < _loc4_)
            {
               _loc3_ = currentBatch[_loc5_];
               if(_loc2_[_loc5_] != true)
               {
                  _failCount = Number(_failCount) + 1;
                  _loc3_.phpLog = _loc2_[_loc5_];
                  _loc3_.print();
               }
               _loc5_++;
            }
         }
         else
         {
            _failCount = Number(_failCount) + 1;
            trace("batchFaild");
         }
         currentBatch.length = 0;
      }
   }
}
