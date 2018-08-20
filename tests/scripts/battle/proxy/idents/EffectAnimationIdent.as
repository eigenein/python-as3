package battle.proxy.idents
{
   import flash.Boot;
   
   public class EffectAnimationIdent
   {
      
      public static var COMMON:EffectAnimationIdent = new EffectAnimationIdent("COMMON");
      
      public static var NONE:EffectAnimationIdent = new EffectAnimationIdent("NONE");
      
      public static var FX1:EffectAnimationIdent = new EffectAnimationIdent("FX");
      
      public static var FX2:EffectAnimationIdent = new EffectAnimationIdent("FX2");
      
      public static var FX3:EffectAnimationIdent = new EffectAnimationIdent("FX3");
      
      public static var FX4:EffectAnimationIdent = new EffectAnimationIdent("FX4");
      
      public static var FX5:EffectAnimationIdent = new EffectAnimationIdent("FX5");
      
      public static var FX6:EffectAnimationIdent = new EffectAnimationIdent("FX6");
      
      public static var FX7:EffectAnimationIdent = new EffectAnimationIdent("FX7");
      
      public static var FX8:EffectAnimationIdent = new EffectAnimationIdent("FX8");
      
      public static var FX9:EffectAnimationIdent = new EffectAnimationIdent("FX9");
      
      public static var BULLET:EffectAnimationIdent = new EffectAnimationIdent("BULLET");
      
      public static var BULLET_HIT:EffectAnimationIdent = new EffectAnimationIdent("BULLET_HIT");
      
      public static var HIT:EffectAnimationIdent = new EffectAnimationIdent("HIT");
       
      
      public var name:String;
      
      public function EffectAnimationIdent(param1:String = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         name = param1;
      }
      
      public function toString() : String
      {
         return "EffectAnimationIdent." + name;
      }
   }
}
