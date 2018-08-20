package battle.data
{
   import flash.Boot;
   
   public class DamageType
   {
      
      public static var collection:Vector.<DamageType> = new Vector.<DamageType>();
      
      public static var ANY:DamageType = new DamageType("any",0);
      
      public static var MAGIC:DamageType = new DamageType("magic",1);
      
      public static var PHYSICAL:DamageType = new DamageType("physical",2);
      
      public static var DOT:DamageType = new DamageType("dot",3);
      
      public static var SILENT:DamageType = new DamageType("silent",4);
      
      public static var ELEMENTAL:DamageType = new DamageType("elemental",5);
      
      public static var FIRE:DamageType = new DamageType("fire",6);
      
      public static var WATER:DamageType = new DamageType("water",7);
      
      public static var EARTH:DamageType = new DamageType("earth",8);
       
      
      public var name:String;
      
      public var id:int;
      
      public function DamageType(param1:String = undefined, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
         id = param2;
         DamageType.collection.push(this);
      }
      
      public static function byIdent(param1:String) : DamageType
      {
         var _loc2_:int = DamageType.collection.length;
         while(true)
         {
            _loc2_--;
            if(_loc2_ <= 0)
            {
               break;
            }
            if(DamageType.collection[_loc2_].name == param1)
            {
               return DamageType.collection[_loc2_];
            }
         }
         return null;
      }
      
      public static function byId(param1:int) : DamageType
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (-1)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function toString() : String
      {
         return name;
      }
   }
}
