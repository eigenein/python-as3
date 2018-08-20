package battle
{
   import battle.data.MainStat;
   import flash.Boot;
   
   public class BattleStats
   {
       
      
      public var strength:Number;
      
      public var physicalCritChance:Number;
      
      public var physicalAttack:Number;
      
      public var magicResist:Number;
      
      public var magicPower:Number;
      
      public var magicPenetration:Number;
      
      public var lifesteal:Number;
      
      public var intelligence:Number;
      
      public var hp:int;
      
      public var dodge:Number;
      
      public var armorPenetration:Number;
      
      public var armor:Number;
      
      public var agility:Number;
      
      public function BattleStats()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         var _loc1_:int = 0;
         hp = _loc1_;
         var _loc2_:Number = _loc1_;
         magicPower = _loc2_;
         _loc2_ = _loc2_;
         physicalCritChance = _loc2_;
         _loc2_ = _loc2_;
         physicalAttack = _loc2_;
         _loc2_ = _loc2_;
         magicPenetration = _loc2_;
         _loc2_ = _loc2_;
         magicResist = _loc2_;
         _loc2_ = _loc2_;
         armorPenetration = _loc2_;
         _loc2_ = _loc2_;
         armor = _loc2_;
         _loc2_ = _loc2_;
         lifesteal = _loc2_;
         _loc2_ = _loc2_;
         dodge = _loc2_;
         _loc2_ = _loc2_;
         strength = _loc2_;
         _loc2_ = _loc2_;
         agility = _loc2_;
         intelligence = _loc2_;
      }
      
      public static function fromRawData(param1:*) : BattleStats
      {
         var _loc3_:Number = NaN;
         var _loc2_:BattleStats = new BattleStats();
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
            _loc3_ = param1.hp;
            _loc2_.hp = int(_loc3_);
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
         return _loc2_;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc6_:* = null as String;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc1_:Array = ["intelligence","agility","strength","hp","physicalAttack","magicPower","armor","magicResist","lifesteal","physicalCritChance","dodge","armorPenetration","magicPenetration"];
         var _loc2_:String = "";
         var _loc3_:int = 0;
         while(_loc3_ < int(_loc1_.length))
         {
            _loc4_ = _loc1_[_loc3_];
            _loc3_++;
            _loc5_ = Reflect.field(this,_loc4_);
            if(_loc5_ != 0)
            {
               _loc6_ = _loc5_;
               _loc2_ = _loc2_ + ("\n" + _loc4_);
               _loc7_ = _loc4_.length + _loc6_.length;
               while(_loc7_ < 23)
               {
                  _loc7_++;
                  _loc8_ = _loc7_;
                  _loc2_ = _loc2_ + " ";
               }
               _loc2_ = _loc2_ + _loc6_;
            }
         }
         return _loc2_;
      }
      
      public function serialize() : *
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc1_:* = {};
         var _loc2_:Array = ["intelligence","agility","strength","hp","physicalAttack","magicPower","armor","magicResist","lifesteal","physicalCritChance","dodge","armorPenetration","magicPenetration"];
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
      
      public function round() : void
      {
         intelligence = Math.round(intelligence * 100) / 100;
         agility = Math.round(agility * 100) / 100;
         strength = Math.round(strength * 100) / 100;
         if(BattleLog.doLog)
         {
            BattleLog.m.logString(physicalAttack + " " + physicalAttack * 100000000);
         }
         physicalAttack = Math.round(physicalAttack * 100) / 100;
         magicPower = Math.round(magicPower * 100) / 100;
         armor = Math.round(armor * 100) / 100;
         magicResist = Math.round(magicResist * 100) / 100;
         lifesteal = Math.round(lifesteal * 100) / 100;
         physicalCritChance = Math.round(physicalCritChance * 100) / 100;
         dodge = Math.round(dodge * 100) / 100;
         armorPenetration = Math.round(armorPenetration * 100) / 100;
         magicPenetration = Math.round(magicPenetration * 100) / 100;
      }
      
      public function processBaseStats(param1:MainStat) : void
      {
         physicalAttack = Number(physicalAttack + (Number((param1 == MainStat.intelligence?intelligence:param1 == MainStat.agility?agility:strength) + agility * 2)));
         hp = int(Number(hp + 40 * strength));
         armor = Number(armor + agility);
         magicPower = Number(magicPower + intelligence * 3);
         magicResist = Number(magicResist + intelligence);
      }
      
      public function nullify() : void
      {
         var _loc1_:int = 0;
         hp = _loc1_;
         var _loc2_:Number = _loc1_;
         magicPower = _loc2_;
         _loc2_ = _loc2_;
         physicalCritChance = _loc2_;
         _loc2_ = _loc2_;
         physicalAttack = _loc2_;
         _loc2_ = _loc2_;
         magicPenetration = _loc2_;
         _loc2_ = _loc2_;
         magicResist = _loc2_;
         _loc2_ = _loc2_;
         armorPenetration = _loc2_;
         _loc2_ = _loc2_;
         armor = _loc2_;
         _loc2_ = _loc2_;
         lifesteal = _loc2_;
         _loc2_ = _loc2_;
         dodge = _loc2_;
         _loc2_ = _loc2_;
         strength = _loc2_;
         _loc2_ = _loc2_;
         agility = _loc2_;
         intelligence = _loc2_;
      }
      
      public function multiply(param1:Number) : void
      {
         intelligence = intelligence * param1;
         agility = agility * param1;
         strength = strength * param1;
         hp = int(hp * param1);
         physicalAttack = physicalAttack * param1;
         magicPower = magicPower * param1;
         armor = armor * param1;
         magicResist = magicResist * param1;
         lifesteal = lifesteal * param1;
         physicalCritChance = physicalCritChance * param1;
         dodge = dodge * param1;
         armorPenetration = armorPenetration * param1;
         magicPenetration = magicPenetration * param1;
      }
      
      public function getMainStatValue(param1:MainStat) : Number
      {
         if(param1 == MainStat.intelligence)
         {
            return intelligence;
         }
         if(param1 == MainStat.agility)
         {
            return agility;
         }
         return strength;
      }
      
      public function getFullHp() : int
      {
         return int(Number(hp + 40 * strength));
      }
      
      public function copyFrom(param1:BattleStats) : void
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
      }
      
      public function clone() : BattleStats
      {
         var _loc1_:BattleStats = new BattleStats();
         _loc1_.copyFrom(this);
         return _loc1_;
      }
      
      public function addMultiply(param1:BattleStats, param2:Number) : void
      {
         if(param1 == null)
         {
            return;
         }
         intelligence = Number(intelligence + param1.intelligence * param2);
         agility = Number(agility + param1.agility * param2);
         strength = Number(strength + param1.strength * param2);
         hp = hp + int(param1.hp * param2);
         physicalAttack = Number(physicalAttack + param1.physicalAttack * param2);
         magicPower = Number(magicPower + param1.magicPower * param2);
         armor = Number(armor + param1.armor * param2);
         magicResist = Number(magicResist + param1.magicResist * param2);
         lifesteal = Number(lifesteal + param1.lifesteal * param2);
         physicalCritChance = Number(physicalCritChance + param1.physicalCritChance * param2);
         dodge = Number(dodge + param1.dodge * param2);
         armorPenetration = Number(armorPenetration + param1.armorPenetration * param2);
         magicPenetration = Number(magicPenetration + param1.magicPenetration * param2);
      }
      
      public function add(param1:BattleStats) : void
      {
         intelligence = Number(intelligence + param1.intelligence);
         agility = Number(agility + param1.agility);
         strength = Number(strength + param1.strength);
         hp = hp + int(param1.hp);
         physicalAttack = Number(physicalAttack + param1.physicalAttack);
         magicPower = Number(magicPower + param1.magicPower);
         armor = Number(armor + param1.armor);
         magicResist = Number(magicResist + param1.magicResist);
         lifesteal = Number(lifesteal + param1.lifesteal);
         physicalCritChance = Number(physicalCritChance + param1.physicalCritChance);
         dodge = Number(dodge + param1.dodge);
         armorPenetration = Number(armorPenetration + param1.armorPenetration);
         magicPenetration = Number(magicPenetration + param1.magicPenetration);
      }
   }
}
