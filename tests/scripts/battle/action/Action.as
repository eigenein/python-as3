package battle.action
{
   import battle.HeroStats;
   import battle.data.DamageType;
   import flash.Boot;
   
   public class Action
   {
       
      
      public var type:DamageType;
      
      public var scale:Number;
      
      public var c:Number;
      
      public var K:Number;
      
      public function Action(param1:* = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(param1 != null)
         {
            if(Reflect.hasField(param1,"type"))
            {
               type = DamageType.byIdent(param1.type);
            }
            else
            {
               type = null;
            }
            if(param1.K || param1.K == 0)
            {
               K = param1.K;
            }
            else
            {
               K = 1;
            }
            if(param1.scale || param1.scale == 0)
            {
               scale = param1.scale;
            }
            else
            {
               scale = 0;
            }
            if(param1.c || param1.c == 0)
            {
               c = param1.c;
            }
            else
            {
               c = 0;
            }
         }
      }
      
      public static function createByParams(param1:String, param2:DamageType, param3:Number = 1, param4:Number = 0, param5:Number = 0) : Action
      {
         var _loc6_:* = null as Action;
         var _loc7_:String = param1;
         if(_loc7_ == "PA")
         {
            _loc6_ = new ActionPA(null);
         }
         else if(_loc7_ == "MP")
         {
            _loc6_ = new ActionMP(null);
         }
         else if(_loc7_ == "HP")
         {
            _loc6_ = new ActionHP(null);
         }
         else
         {
            _loc6_ = new Action(null);
         }
         _loc6_.type = param2;
         _loc6_.K = param3;
         _loc6_.scale = param4;
         _loc6_.c = param5;
         return _loc6_;
      }
      
      public static function createConst(param1:Number, param2:DamageType = undefined) : Action
      {
         var _loc3_:Action = new Action(null);
         _loc3_.type = param2;
         _loc3_.K = 0;
         _loc3_.scale = 0;
         _loc3_.c = param1;
         return _loc3_;
      }
      
      public static function create(param1:*) : Action
      {
         var _loc2_:* = null as String;
         var _loc3_:* = null as String;
         if(Reflect.hasField(param1,"base"))
         {
            _loc2_ = param1.base;
            _loc3_ = _loc2_;
            if(_loc3_ == "PA")
            {
               return new ActionPA(param1);
            }
            if(_loc3_ == "MP")
            {
               return new ActionMP(param1);
            }
            if(_loc3_ == "HP")
            {
               return new ActionHP(param1);
            }
            return new Action(param1);
         }
         return new Action(param1);
      }
      
      public function toJSON(param1:*) : *
      {
         if(type == null)
         {
            return {
               "K":K,
               "scale":scale,
               "c":c,
               "base":getBase()
            };
         }
         return {
            "type":type.name,
            "K":K,
            "scale":scale,
            "c":c,
            "base":getBase()
         };
      }
      
      public function getValue(param1:HeroStats, param2:int) : Number
      {
         return Number(scale * param2 + c);
      }
      
      public function getBase() : String
      {
         return null;
      }
   }
}
