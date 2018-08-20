package game.battle.view.animation
{
   import battle.data.BattleSkillDescription;
   import com.progrestar.framework.ares.core.Clip;
   import com.progrestar.framework.ares.starling.ClipAssetDataProvider;
   import com.progrestar.framework.ares.starling.ClipSkin;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import game.battle.view.BattleScene;
   import game.battle.view.EffectGraphicsProvider;
   import game.battle.view.hero.HeroView;
   
   public class OnceEffectAnimationFactory
   {
      
      private static const instance:OnceEffectAnimationFactory = new OnceEffectAnimationFactory();
       
      
      private const playOnce:Boolean = true;
      
      private var scene:BattleScene;
      
      private var fxProvider:EffectGraphicsProvider;
      
      private var transform:Matrix;
      
      private var timeOffset:Number;
      
      private var skill:BattleSkillDescription;
      
      private var tickOnPause:Boolean;
      
      private var assetProvider:ClipAssetDataProvider;
      
      private var targetHero:HeroView;
      
      private var targetSpace:ZSortedSprite;
      
      public function OnceEffectAnimationFactory()
      {
         super();
      }
      
      public static function factory(param1:BattleScene, param2:EffectGraphicsProvider, param3:Matrix, param4:Number, param5:BattleSkillDescription, param6:Boolean) : OnceEffectAnimationFactory
      {
         if(param3 == null)
         {
            param3 = param2.transform;
         }
         else
         {
            concatLeft(param3,param2.transform);
         }
         instance.scene = param1;
         instance.fxProvider = param2;
         instance.transform = param3;
         instance.timeOffset = param4;
         instance.skill = param5;
         instance.tickOnPause = param6;
         instance.assetProvider = param2.clipAssetDataProvider;
         return instance;
      }
      
      protected static function concatLeft(param1:Matrix, param2:Matrix) : void
      {
         param1.setTo(param2.a * param1.a + param2.b * param1.c,param2.a * param1.b + param2.b * param1.d,param2.c * param1.a + param2.d * param1.c,param2.c * param1.b + param2.d * param1.d,param2.tx * param1.a + param2.ty * param1.c + param1.tx,param2.tx * param1.b + param2.ty * param1.d + param1.ty);
      }
      
      public function createOnHero(param1:HeroView) : void
      {
         targetHero = param1;
         targetSpace = null;
         if(fxProvider.front)
         {
            createFx(fxProvider.createFrontSkin(),true,param1.position.size + 1);
         }
         if(fxProvider.back)
         {
            createFx(fxProvider.createBackSkin(),true,-param1.position.size - 1);
         }
         if(fxProvider.displacement)
         {
            createDisplacement(fxProvider.displacement,true,-param1.position.size - 1);
         }
         if(fxProvider.container)
         {
            createContainer(fxProvider.container,true,5);
         }
      }
      
      public function createOnScene(param1:ZSortedSprite, param2:Number) : void
      {
         targetHero = null;
         targetSpace = param1;
         if(fxProvider.front)
         {
            createFx(fxProvider.createFrontSkin(),true,param2 + 10);
         }
         if(fxProvider.back)
         {
            createFx(fxProvider.createBackSkin(),true,param2 + -1000000);
         }
         if(fxProvider.displacement)
         {
            createDisplacement(fxProvider.displacement,true,param2 + 10);
         }
      }
      
      protected function createFx(param1:ClipSkin, param2:Boolean, param3:Number) : BattleFx
      {
         var _loc4_:BattleFx = new BattleFx(param2,param3);
         _loc4_.skin = param1;
         _loc4_.assetTransform = transform;
         if(targetHero)
         {
            _loc4_.targetHero = targetHero;
         }
         if(targetSpace)
         {
            _loc4_.targetSpace = targetSpace;
         }
         scene.addFx(_loc4_,skill,tickOnPause);
         _loc4_.advanceTime(timeOffset);
         return _loc4_;
      }
      
      protected function createDisplacement(param1:Clip, param2:Boolean, param3:Number) : BattleFx
      {
         var _loc4_:BattleFx = new BattleFx(param2,param3);
         _loc4_.skin = new ClipSkin(param1,assetProvider);
         _loc4_.assetTransform = transform;
         if(targetHero)
         {
            _loc4_.targetHero = targetHero;
         }
         if(targetSpace)
         {
            _loc4_.targetSpace = targetSpace;
         }
         scene.postProcessing.displacmentAffectorsContainer.addChild(_loc4_.graphics);
         scene.addFx(_loc4_,skill,tickOnPause);
         _loc4_.advanceTime(timeOffset);
         return _loc4_;
      }
      
      protected function createContainer(param1:Clip, param2:Boolean, param3:Number) : BattleFx
      {
         var _loc4_:ContainerBattleFx = new ContainerBattleFx(param2,param3);
         _loc4_.clip = param1;
         _loc4_.assetTransform = transform;
         if(targetHero)
         {
            _loc4_.targetHero = targetHero;
         }
         if(targetSpace)
         {
            _loc4_.targetSpace = targetSpace;
         }
         scene.addFx(_loc4_,skill,tickOnPause);
         _loc4_.advanceTime(timeOffset);
         return _loc4_;
      }
   }
}
