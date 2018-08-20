package game.battle.view
{
   import battle.proxy.idents.EffectAnimationIdent;
   import flash.utils.Dictionary;
   
   public class BattleHeroEffectMapping
   {
      
      private static var actionMapping:Vector.<String>;
      
      private static var suffixMapping:Dictionary;
       
      
      public function BattleHeroEffectMapping()
      {
         super();
      }
      
      public static function getAnimation(param1:EffectAnimationIdent, param2:int) : String
      {
         if(actionMapping == null)
         {
            createMapping();
         }
         return actionMapping[param2] + suffixMapping[param1];
      }
      
      public static function getAnimationByString(param1:String, param2:int) : String
      {
         if(actionMapping == null)
         {
            createMapping();
         }
         if(param2 >= actionMapping.length)
         {
            return null;
         }
         return actionMapping[param2] + "_" + param1;
      }
      
      private static function createMapping() : void
      {
         actionMapping = new <String>["ATTACK","ULT","SKILL1","SKILL2","SKILL3"];
         suffixMapping = new Dictionary();
         suffixMapping[EffectAnimationIdent.FX1] = "_FX";
         suffixMapping[EffectAnimationIdent.FX2] = "_FX2";
         suffixMapping[EffectAnimationIdent.FX3] = "_FX3";
         suffixMapping[EffectAnimationIdent.FX4] = "_FX4";
         suffixMapping[EffectAnimationIdent.FX5] = "_FX5";
         suffixMapping[EffectAnimationIdent.BULLET] = "_BULLET";
         suffixMapping[EffectAnimationIdent.HIT] = "_HIT";
      }
   }
}
