package battle
{
   import battle.data.MainStat;
   import battle.utils.Version;
   import flash.Boot;
   
   public class HeroStats extends BattleStats
   {
      
      public static var DEFAULT_MAX_ENERGY:Number = 1000;
      
      public static var INFINITE_HP:int = 1000000;
       
      
      public var mainStat:MainStat;
      
      public var antidodge:Number;
      
      public var anticrit:Number;
      
      public var accuracy:Number;
      
      public function HeroStats(param1:MainStat = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         mainStat = param1;
         var _loc2_:* = 0;
         accuracy = _loc2_;
         _loc2_ = Number(_loc2_);
         antidodge = _loc2_;
         anticrit = _loc2_;
         super();
      }
      
      public static function buff(param1:String, param2:Number) : HeroStats
      {
         var _loc4_:* = null;
         var _loc3_:HeroStats = new HeroStats();
         if(Reflect.hasField(_loc3_,param1))
         {
            _loc4_ = Reflect.field(_loc3_,param1) + param2;
            _loc3_[param1] = _loc4_;
         }
         return _loc3_;
      }
      
      public static function fromRawData(param1:*) : HeroStats
      {
         var _loc2_:HeroStats = new HeroStats();
         var _loc3_:int = 0;
         _loc2_.hp = _loc3_;
         var _loc4_:* = Number(_loc3_);
         _loc2_.magicPower = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.physicalCritChance = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.physicalAttack = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.magicPenetration = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.magicResist = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.armorPenetration = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.armor = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.lifesteal = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.dodge = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.strength = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.agility = _loc4_;
         _loc2_.intelligence = _loc4_;
         _loc4_ = 0;
         _loc2_.accuracy = _loc4_;
         _loc4_ = Number(_loc4_);
         _loc2_.antidodge = _loc4_;
         _loc2_.anticrit = _loc4_;
         if(param1.intelligence)
         {
            _loc2_.intelligence = param1.intelligence;
         }
         if(param1.agility)
         {
            _loc2_.agility = param1.agility;
         }
         if(param1.strength)
         {
            _loc2_.strength = param1.strength;
         }
         if(param1.hp)
         {
            _loc2_.hp = param1.hp;
         }
         if(param1.physicalAttack)
         {
            _loc2_.physicalAttack = param1.physicalAttack;
         }
         if(param1.magicPower)
         {
            _loc2_.magicPower = param1.magicPower;
         }
         if(param1.armor)
         {
            _loc2_.armor = param1.armor;
         }
         if(param1.magicResist)
         {
            _loc2_.magicResist = param1.magicResist;
         }
         if(param1.lifesteal)
         {
            _loc2_.lifesteal = param1.lifesteal;
         }
         if(param1.physicalCritChance)
         {
            _loc2_.physicalCritChance = param1.physicalCritChance;
         }
         if(param1.dodge)
         {
            _loc2_.dodge = param1.dodge;
         }
         if(param1.armorPenetration)
         {
            _loc2_.armorPenetration = param1.armorPenetration;
         }
         if(param1.magicPenetration)
         {
            _loc2_.magicPenetration = param1.magicPenetration;
         }
         if(param1.anticrit)
         {
            _loc2_.anticrit = param1.anticrit;
         }
         if(param1.antidodge)
         {
            _loc2_.antidodge = param1.antidodge;
         }
         if(param1.accuracy)
         {
            _loc2_.accuracy = param1.accuracy;
         }
         if(param1.hasOwnProperty("mainStat"))
         {
            if(_loc2_.mainStat is MainStat)
            {
               _loc2_.mainStat = param1.mainStat;
            }
            else if(param1.mainStat.hasOwnProperty("name"))
            {
               _loc2_.mainStat = MainStat.fromString(param1.mainStat.name);
            }
            else
            {
               _loc2_.mainStat = MainStat.fromString(param1.mainStat);
            }
         }
         return _loc2_;
      }
      
      public static function fromBaseStats(param1:Number, param2:Number, param3:Number, param4:MainStat) : HeroStats
      {
         var _loc5_:HeroStats = new HeroStats(param4);
         _loc5_.intelligence = param1;
         _loc5_.agility = param2;
         _loc5_.strength = param3;
         var _loc6_:MainStat = _loc5_.mainStat;
         _loc5_.physicalAttack = Number(_loc5_.physicalAttack + (Number((_loc6_ == MainStat.intelligence?_loc5_.intelligence:_loc6_ == MainStat.agility?_loc5_.agility:_loc5_.strength) + _loc5_.agility * 2)));
         _loc5_.hp = int(Number(_loc5_.hp + 40 * _loc5_.strength));
         _loc5_.armor = Number(_loc5_.armor + _loc5_.agility);
         _loc5_.magicPower = Number(_loc5_.magicPower + _loc5_.intelligence * 3);
         _loc5_.magicResist = Number(_loc5_.magicResist + _loc5_.intelligence);
         _loc6_ = _loc5_.mainStat;
         if(_loc6_ == MainStat.intelligence)
         {
            _loc5_.antidodge = Number(_loc5_.antidodge + _loc5_.intelligence);
         }
         else if(_loc6_ == MainStat.agility)
         {
            _loc5_.antidodge = Number(_loc5_.antidodge + _loc5_.agility);
         }
         else
         {
            _loc5_.antidodge = Number(_loc5_.antidodge + _loc5_.strength);
         }
         _loc6_ = _loc5_.mainStat;
         if(_loc6_ == MainStat.intelligence)
         {
            _loc5_.anticrit = Number(_loc5_.anticrit + _loc5_.intelligence);
         }
         else if(_loc6_ == MainStat.agility)
         {
            _loc5_.anticrit = Number(_loc5_.anticrit + _loc5_.agility);
         }
         else
         {
            _loc5_.anticrit = Number(_loc5_.anticrit + _loc5_.strength);
         }
         return _loc5_;
      }
      
      override public function toString() : String
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc6_:* = null as String;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc1_:String = "HeroStats  mainStat: " + Std.string(mainStat) + super.toString();
         var _loc2_:Array = ["anticrit","antidodge","accuracy"];
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            _loc5_ = Reflect.field(this,_loc4_);
            if(_loc5_ != 0)
            {
               _loc6_ = _loc5_;
               _loc1_ = _loc1_ + ("\n" + _loc4_);
               _loc7_ = _loc4_.length + _loc6_.length;
               while(_loc7_ < 23)
               {
                  _loc7_++;
                  _loc8_ = _loc7_;
                  _loc1_ = _loc1_ + " ";
               }
               _loc1_ = _loc1_ + _loc6_;
            }
         }
         return _loc1_;
      }
      
      public function setByBaseStatsStr(param1:Number, param2:Number, param3:Number, param4:String) : void
      {
         var _loc5_:int = 0;
         hp = _loc5_;
         var _loc6_:* = Number(_loc5_);
         magicPower = _loc6_;
         _loc6_ = Number(_loc6_);
         physicalCritChance = _loc6_;
         _loc6_ = Number(_loc6_);
         physicalAttack = _loc6_;
         _loc6_ = Number(_loc6_);
         magicPenetration = _loc6_;
         _loc6_ = Number(_loc6_);
         magicResist = _loc6_;
         _loc6_ = Number(_loc6_);
         armorPenetration = _loc6_;
         _loc6_ = Number(_loc6_);
         armor = _loc6_;
         _loc6_ = Number(_loc6_);
         lifesteal = _loc6_;
         _loc6_ = Number(_loc6_);
         dodge = _loc6_;
         _loc6_ = Number(_loc6_);
         strength = _loc6_;
         _loc6_ = Number(_loc6_);
         agility = _loc6_;
         intelligence = _loc6_;
         _loc6_ = 0;
         accuracy = _loc6_;
         _loc6_ = Number(_loc6_);
         antidodge = _loc6_;
         anticrit = _loc6_;
         mainStat = MainStat.fromString(param4);
         intelligence = param1;
         agility = param2;
         strength = param3;
         var _loc7_:MainStat = mainStat;
         physicalAttack = Number(physicalAttack + (Number((_loc7_ == MainStat.intelligence?intelligence:_loc7_ == MainStat.agility?agility:strength) + agility * 2)));
         hp = int(Number(hp + 40 * strength));
         armor = Number(armor + agility);
         magicPower = Number(magicPower + intelligence * 3);
         magicResist = Number(magicResist + intelligence);
         _loc7_ = mainStat;
         if(_loc7_ == MainStat.intelligence)
         {
            antidodge = Number(antidodge + intelligence);
         }
         else if(_loc7_ == MainStat.agility)
         {
            antidodge = Number(antidodge + agility);
         }
         else
         {
            antidodge = Number(antidodge + strength);
         }
         _loc7_ = mainStat;
         if(_loc7_ == MainStat.intelligence)
         {
            anticrit = Number(anticrit + intelligence);
         }
         else if(_loc7_ == MainStat.agility)
         {
            anticrit = Number(anticrit + agility);
         }
         else
         {
            anticrit = Number(anticrit + strength);
         }
      }
      
      public function setByBaseStats(param1:Number, param2:Number, param3:Number, param4:MainStat) : void
      {
         var _loc5_:int = 0;
         hp = _loc5_;
         var _loc6_:* = Number(_loc5_);
         magicPower = _loc6_;
         _loc6_ = Number(_loc6_);
         physicalCritChance = _loc6_;
         _loc6_ = Number(_loc6_);
         physicalAttack = _loc6_;
         _loc6_ = Number(_loc6_);
         magicPenetration = _loc6_;
         _loc6_ = Number(_loc6_);
         magicResist = _loc6_;
         _loc6_ = Number(_loc6_);
         armorPenetration = _loc6_;
         _loc6_ = Number(_loc6_);
         armor = _loc6_;
         _loc6_ = Number(_loc6_);
         lifesteal = _loc6_;
         _loc6_ = Number(_loc6_);
         dodge = _loc6_;
         _loc6_ = Number(_loc6_);
         strength = _loc6_;
         _loc6_ = Number(_loc6_);
         agility = _loc6_;
         intelligence = _loc6_;
         _loc6_ = 0;
         accuracy = _loc6_;
         _loc6_ = Number(_loc6_);
         antidodge = _loc6_;
         anticrit = _loc6_;
         mainStat = param4;
         intelligence = param1;
         agility = param2;
         strength = param3;
         var _loc7_:MainStat = mainStat;
         physicalAttack = Number(physicalAttack + (Number((_loc7_ == MainStat.intelligence?intelligence:_loc7_ == MainStat.agility?agility:strength) + agility * 2)));
         hp = int(Number(hp + 40 * strength));
         armor = Number(armor + agility);
         magicPower = Number(magicPower + intelligence * 3);
         magicResist = Number(magicResist + intelligence);
         _loc7_ = mainStat;
         if(_loc7_ == MainStat.intelligence)
         {
            antidodge = Number(antidodge + intelligence);
         }
         else if(_loc7_ == MainStat.agility)
         {
            antidodge = Number(antidodge + agility);
         }
         else
         {
            antidodge = Number(antidodge + strength);
         }
         _loc7_ = mainStat;
         if(_loc7_ == MainStat.intelligence)
         {
            anticrit = Number(anticrit + intelligence);
         }
         else if(_loc7_ == MainStat.agility)
         {
            anticrit = Number(anticrit + agility);
         }
         else
         {
            anticrit = Number(anticrit + strength);
         }
      }
      
      override public function serialize() : *
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc1_:* = super.serialize();
         var _loc2_:Array = ["anticrit","antidodge","accuracy"];
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc2_.length))
         {
            _loc4_ = _loc2_[_loc3_];
            _loc3_++;
            _loc5_ = this[_loc4_];
            if(_loc5_ != 0)
            {
               _loc1_[_loc4_] = _loc5_;
            }
         }
         return _loc1_;
      }
      
      public function processHeroStats() : void
      {
         var _loc1_:MainStat = mainStat;
         physicalAttack = Number(physicalAttack + (Number((_loc1_ == MainStat.intelligence?intelligence:_loc1_ == MainStat.agility?agility:strength) + agility * 2)));
         hp = int(Number(hp + 40 * strength));
         armor = Number(armor + agility);
         magicPower = Number(magicPower + intelligence * 3);
         magicResist = Number(magicResist + intelligence);
         _loc1_ = mainStat;
         if(_loc1_ == MainStat.intelligence)
         {
            antidodge = Number(antidodge + intelligence);
         }
         else if(_loc1_ == MainStat.agility)
         {
            antidodge = Number(antidodge + agility);
         }
         else
         {
            antidodge = Number(antidodge + strength);
         }
         _loc1_ = mainStat;
         if(_loc1_ == MainStat.intelligence)
         {
            anticrit = Number(anticrit + intelligence);
         }
         else if(_loc1_ == MainStat.agility)
         {
            anticrit = Number(anticrit + agility);
         }
         else
         {
            anticrit = Number(anticrit + strength);
         }
      }
      
      public function copyFromHeroStats(param1:HeroStats) : void
      {
         intelligence = param1.intelligence;
         agility = param1.agility;
         strength = param1.strength;
         hp = int(param1.hp);
         physicalAttack = param1.physicalAttack;
         magicPower = param1.magicPower;
         armor = param1.armor;
         magicResist = param1.magicResist;
         lifesteal = param1.lifesteal;
         physicalCritChance = param1.physicalCritChance;
         dodge = param1.dodge;
         armorPenetration = param1.armorPenetration;
         magicPenetration = param1.magicPenetration;
         anticrit = param1.anticrit;
         antidodge = param1.antidodge;
         accuracy = param1.accuracy;
         if(Version.current >= 92)
         {
            mainStat = param1.mainStat;
         }
      }
      
      override public function copyFrom(param1:BattleStats) : void
      {
         intelligence = param1.intelligence;
         agility = param1.agility;
         strength = param1.strength;
         hp = int(param1.hp);
         physicalAttack = param1.physicalAttack;
         magicPower = param1.magicPower;
         armor = param1.armor;
         magicResist = param1.magicResist;
         lifesteal = param1.lifesteal;
         physicalCritChance = param1.physicalCritChance;
         dodge = param1.dodge;
         armorPenetration = param1.armorPenetration;
         magicPenetration = param1.magicPenetration;
         var _loc2_:* = 0;
         accuracy = _loc2_;
         _loc2_ = Number(_loc2_);
         antidodge = _loc2_;
         anticrit = _loc2_;
      }
      
      public function cloneHeroStats() : HeroStats
      {
         var _loc1_:HeroStats = new HeroStats();
         _loc1_.copyFrom(this);
         _loc1_.mainStat = mainStat;
         _loc1_.anticrit = anticrit;
         _loc1_.antidodge = antidodge;
         _loc1_.accuracy = accuracy;
         return _loc1_;
      }
      
      public function checkCap() : void
      {
         if(magicPower < 0)
         {
            magicPower = 0;
         }
         if(physicalAttack < 0)
         {
            physicalAttack = 0;
         }
         if(hp < 0)
         {
            hp = 0;
         }
         if(lifesteal < 0)
         {
            lifesteal = 0;
         }
      }
      
      public function addBuff(param1:String, param2:Number) : void
      {
         var _loc3_:* = null;
         if(Reflect.hasField(this,param1))
         {
            _loc3_ = Reflect.field(this,param1) + param2;
            this[param1] = _loc3_;
         }
      }
   }
}
