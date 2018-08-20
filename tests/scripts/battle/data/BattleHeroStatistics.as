package battle.data
{
   import flash.Boot;
   
   public class BattleHeroStatistics
   {
       
      
      public var physicalDamageResisted:int;
      
      public var physicalDamageRecieved:int;
      
      public var physicalDamageDealt:int;
      
      public var physicalDamageAbsorbed:int;
      
      public var magicDamageResisted:int;
      
      public var magicDamageRecieved:int;
      
      public var magicDamageDealt:int;
      
      public var magicDamageAbsorbed:int;
      
      public var healingReceived:Number;
      
      public var healingDealt:int;
      
      public var energySpent:Number;
      
      public var energyGained:Number;
      
      public var damageResisted:int;
      
      public var damageRecieved:int;
      
      public var damageMissed:int;
      
      public var damageDodged:int;
      
      public var damageDealt:int;
      
      public var damageBySkill:Vector.<int>;
      
      public function BattleHeroStatistics()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         damageBySkill = new Vector.<int>();
         energySpent = 0;
         energyGained = 0;
         healingDealt = 0;
         healingReceived = 0;
         damageMissed = 0;
         damageDodged = 0;
         magicDamageAbsorbed = 0;
         magicDamageResisted = 0;
         magicDamageRecieved = 0;
         physicalDamageAbsorbed = 0;
         physicalDamageResisted = 0;
         physicalDamageRecieved = 0;
         damageResisted = 0;
         damageRecieved = 0;
         physicalDamageDealt = 0;
         magicDamageDealt = 0;
         damageDealt = 0;
         damageBySkill[0] = 0;
         damageBySkill[1] = 0;
         damageBySkill[2] = 0;
         damageBySkill[3] = 0;
         damageBySkill[4] = 0;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as String;
         var _loc5_:* = null;
         var _loc6_:* = null as String;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc1_:String = "HeroStatistics  damagePerSkills: " + Std.string(damageBySkill);
         var _loc2_:Array = ["damageDealt","magicDamageDealt","physicalDamageDealt","damageRecieved","damageResisted","physicalDamageRecieved","physicalDamageResisted","physicalDamageAbsorbed","magicDamageRecieved","magicDamageResisted","magicDamageAbsorbed","damageDodged","damageMissed","healingReceived","healingDealt","energyGained","energySpent"];
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
      
      public function dealDamage() : void
      {
      }
   }
}
