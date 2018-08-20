package game.battle.view.hero
{
   import battle.proxy.ViewTransform;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.animation.EffectAnimationSet;
   
   public class BattleHeroPermanentFx
   {
      
      public static var PERMANENT_FX:String = "permanent_fx";
       
      
      protected var hero:HeroView;
      
      protected var permanentFx:EffectAnimationSet;
      
      protected var transform:ViewTransform;
      
      public function BattleHeroPermanentFx(param1:HeroView, param2:HeroClipAssetDataProvider)
      {
         super();
         var _loc3_:EffectGraphicsProvider = param2.getEffectProvider(PERMANENT_FX);
         permanentFx = new EffectAnimationSet();
         permanentFx.setGraphics(_loc3_);
         this.hero = param1;
         if(param1.transform.parent)
         {
            permanentFx.targetHero = param1;
            transform = new ViewTransform();
         }
      }
      
      public static function assetHasFx(param1:HeroClipAssetDataProvider) : Boolean
      {
         return EffectGraphicsProvider.hasFx(param1,PERMANENT_FX);
      }
      
      public function dispose() : void
      {
         permanentFx.dispose();
      }
      
      public function advanceTime(param1:Number) : void
      {
         if(transform == null)
         {
            if(hero.transform.parent)
            {
               permanentFx.targetHero = hero;
               transform = new ViewTransform();
            }
         }
         if(transform != null)
         {
            transform.copyFrom(hero.viewTransform);
            permanentFx.setTransform(transform);
            permanentFx.advanceTime(param1);
         }
      }
   }
}
