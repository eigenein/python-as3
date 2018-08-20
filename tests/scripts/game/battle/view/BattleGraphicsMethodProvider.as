package game.battle.view
{
   import avmplus.getQualifiedClassName;
   import battle.Hero;
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import battle.proxy.CustomAbilityProxy;
   import battle.proxy.displayEvents.CustomManualActionEvent;
   import battle.proxy.displayEvents.SimpleFxEvent;
   import battle.skills.Effect;
   import battle.skills.TeamEffect;
   import engine.core.animation.ZSortedSprite;
   import flash.geom.Matrix;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.gui.BattleGuiViewBase;
   import game.battle.gui.teambuffs.BattleTeamEffectIcon;
   import game.battle.gui.teamskill.BattleGuiFx;
   import game.battle.view.animation.BattleFx;
   import game.battle.view.animation.OnceEffectAnimationFactory;
   import game.battle.view.hero.HeroClipAssetDataProvider;
   import game.battle.view.hero.HeroView;
   import game.battle.view.systems.IBattleDisposable;
   import game.battle.view.text.BattleFloatingTextStyle;
   import game.battle.view.text.BattleGraphicsTextMethodProvider;
   import game.battle.view.ult.UltAnimationCast;
   import game.data.reward.RewardData;
   import game.data.storage.DataStorage;
   import game.data.storage.skills.SkillDescription;
   
   public class BattleGraphicsMethodProvider
   {
       
      
      public var container:ZSortedSprite;
      
      private var asset:BattleGraphicsProvider;
      
      private var scene:BattleScene;
      
      private var gui:BattleGuiViewBase;
      
      private var timeOffset:Number;
      
      public const text:BattleGraphicsTextMethodProvider = new BattleGraphicsTextMethodProvider(this);
      
      public function BattleGraphicsMethodProvider(param1:BattleGraphicsProvider, param2:BattleScene, param3:BattleGuiViewBase)
      {
         super();
         this.asset = param1;
         this.scene = param2;
         this.gui = param3;
         container = param2.animationTarget;
         text.setScene(param2);
      }
      
      public function getHeroView(param1:BattleHeroDescription) : HeroView
      {
         return scene.getHeroView(param1);
      }
      
      public function getOrCreateHeroView(param1:BattleHeroDescription) : HeroView
      {
         var _loc2_:HeroView = scene.getHeroView(param1);
         if(_loc2_ == null)
         {
            _loc2_ = new HeroView();
            _loc2_.position.scale = param1.scale;
            _loc2_.applyAsset(asset.getHeroAsset(param1));
            scene.addHeroView(param1,_loc2_);
         }
         return _loc2_;
      }
      
      public function freeHeroView(param1:BattleHeroDescription) : void
      {
         scene.freeHeroView(param1);
      }
      
      public function attachHeroPanel(param1:BattleHeroControllerWithPanel) : void
      {
         gui.attachHeroPanel(param1);
      }
      
      public function ultAnimation(param1:UltAnimationCast) : void
      {
         scene.ultController.startUlt(param1);
      }
      
      public function addGuiFx(param1:BattleGuiFx) : void
      {
         gui.addFx(param1);
      }
      
      public function showUltName(param1:int, param2:int) : void
      {
         var _loc3_:SkillDescription = DataStorage.skill.getByHeroAndTier(param1,param2);
         gui.startUlt(_loc3_.name);
      }
      
      public function dropReward(param1:BattleHero, param2:RewardData) : void
      {
         gui.addDroppedReward(param2);
      }
      
      public function addBossHpBar(param1:BattleHero) : void
      {
         var _loc2_:BattleBossHpBar = new BattleBossHpBar(param1);
         gui.addBossHpBar(_loc2_);
      }
      
      public function addTeamEffect(param1:TeamEffect, param2:String) : void
      {
         var _loc3_:BattleTeamEffectIcon = new BattleTeamEffectIcon(param1,param2);
         gui.addTeamEffect(_loc3_);
      }
      
      public function createOnceHeroFx(param1:HeroView, param2:EffectGraphicsProvider, param3:Matrix, param4:BattleSkillDescription, param5:Boolean) : void
      {
         if(!param2 || param2 == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         var _loc6_:OnceEffectAnimationFactory = OnceEffectAnimationFactory.factory(scene,param2,param3,timeOffset,param4,param5);
         _loc6_.createOnHero(param1);
      }
      
      public function createOnceGlobalFx(param1:EffectGraphicsProvider, param2:Matrix = null, param3:Number = 0, param4:BattleSkillDescription = null, param5:Boolean = false) : void
      {
         if(param1 == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         var _loc6_:OnceEffectAnimationFactory = OnceEffectAnimationFactory.factory(scene,param1,param2,timeOffset,param4,param5);
         _loc6_.createOnScene(scene.sortedContainer,param3);
      }
      
      public function getHeroAsset(param1:BattleHeroDescription, param2:Number = 1, param3:String = null) : HeroClipAssetDataProvider
      {
         return asset.getHeroAsset(param1,param2,param3);
      }
      
      public function getFxAsset(param1:*, param2:Effect, param3:Number) : EffectGraphicsProvider
      {
         return asset.getEffect(param1,param2,param3);
      }
      
      public function getHeroEffect(param1:int, param2:String, param3:BattleHeroDescription) : EffectGraphicsProvider
      {
         return asset.getHeroEffect(param1,param2,param3,param3.scale);
      }
      
      public function getCommonEffect(param1:String) : EffectGraphicsProvider
      {
         return asset.getCommonEffect(param1);
      }
      
      public function getHurtFx() : EffectGraphicsProvider
      {
         return asset.getCommonEffect("hurt");
      }
      
      public function getDodgeFx() : EffectGraphicsProvider
      {
         return asset.getCommonEffect("dodge");
      }
      
      public function getHeroSkillOnHit(param1:int, param2:BattleHeroDescription) : EffectGraphicsProvider
      {
         return asset.getOnHitEffect(param1,param2);
      }
      
      public function addFx(param1:IBattleDisposable, param2:BattleSkillDescription = null, param3:Boolean = false) : void
      {
         scene.addFx(param1,param2,param3);
      }
      
      public function addDisplacement(param1:BattleFx) : void
      {
         scene.postProcessing.displacmentAffectorsContainer.addChild(param1.graphics);
      }
      
      public function addFxEvent(param1:SimpleFxEvent) : void
      {
         var _loc2_:* = null;
         var _loc3_:* = null;
         if(param1.fxSkill == null)
         {
            _loc2_ = asset.getCommonEffect(param1.fx.name);
         }
         else
         {
            _loc2_ = asset.getHeroEffect(param1.fxSkill.tier,param1.fx.name,param1.fxSkill.hero,getHeroView(param1.fxSkill.hero).transform.scale);
         }
         if(_loc2_ == null || _loc2_ == EffectGraphicsProvider.MISSING)
         {
            return;
         }
         var _loc7_:int = param1.explicitDirection;
         if(_loc7_ == 0 && param1.targetHero != null)
         {
            _loc7_ = param1.targetHero.getVisualDirection();
         }
         var _loc6_:Matrix = new Matrix(_loc7_,0,0,1,param1.position,0);
         if(param1.yTargetHero != null)
         {
            _loc3_ = getHeroView(param1.yTargetHero.desc);
            if(_loc3_)
            {
               _loc6_.ty = _loc3_.position.y;
            }
         }
         var _loc4_:OnceEffectAnimationFactory = OnceEffectAnimationFactory.factory(scene,_loc2_,_loc6_,timeOffset,param1.fxSkill,param1.playOnPause);
         var _loc5_:* = 0;
         if(param1.zOffset != null)
         {
            _loc5_ = Number(param1.zOffset);
         }
         if(param1.targetHero != null)
         {
            _loc3_ = getHeroView(param1.targetHero.desc);
            if(_loc3_)
            {
               _loc4_.createOnHero(_loc3_);
            }
            else
            {
               trace(getQualifiedClassName(this),"HeroView not found for",param1.targetHero.desc.name);
            }
         }
         else
         {
            _loc4_.createOnScene(scene.sortedContainer,_loc5_);
         }
      }
      
      public function addCustomManualActionEvent(param1:CustomManualActionEvent) : void
      {
         gui.addCustomManualActionEvent(param1);
      }
      
      public function addTeamSkill(param1:CustomAbilityProxy) : void
      {
         gui.addTeamSkill(param1);
      }
      
      public function getGlobalAnimationTarget() : ZSortedSprite
      {
         return scene.animationTarget;
      }
      
      public function shakeScreen(param1:Number, param2:int, param3:Number) : void
      {
         scene.shakeController.add(param1,param2,param3);
      }
      
      public function freezeScreen(param1:Number) : void
      {
         scene.freezeScreen(param1);
      }
      
      public function setSceneTimeOffset(param1:Number) : void
      {
         this.timeOffset = param1;
      }
      
      public function setHeroCameraTracking(param1:HeroView, param2:Boolean) : void
      {
         scene.setHeroCameraTracking(param1,param2);
      }
      
      public function getTerrainHeight(param1:Number, param2:Number) : Number
      {
         return scene.getTerrainHeight(param1,param2);
      }
      
      public function createText(param1:HeroView, param2:String, param3:BattleFloatingTextStyle, param4:String = null) : void
      {
         scene.textController.createFloating(param1,param2,param3,param4);
      }
      
      public function createEnergyText(param1:HeroView, param2:String, param3:BattleFloatingTextStyle, param4:Number, param5:Number, param6:Boolean) : void
      {
         scene.textController.createFloatingEnergy(param1,param2,param3,param4,param5,param6);
      }
      
      public function highlightArea(param1:Number, param2:Number, param3:int, param4:Hero) : void
      {
         var _loc7_:* = null;
         var _loc12_:* = NaN;
         var _loc5_:Number = NaN;
         var _loc8_:Number = NaN;
         if(param3 > 4)
         {
            param3 = 4;
         }
         var _loc6_:EffectGraphicsProvider = asset.getCommonEffect("areaTier" + param3);
         var _loc11_:Matrix = new Matrix((param2 - param1) / 100,0,0,1,param1,0);
         var _loc10_:* = -100;
         if(param4 != null)
         {
            _loc7_ = getHeroView(param4.desc);
            if(_loc7_)
            {
               _loc11_.ty = _loc7_.position.y;
            }
            _loc12_ = 100;
            if(param3 == 1 || param3 == 4)
            {
               _loc12_ = Number(250);
            }
            else if(param3 == 3)
            {
               _loc12_ = Number(200);
            }
            else if(param3 == 2)
            {
               _loc12_ = 100;
            }
            _loc11_.d = _loc12_ / 100;
         }
         else
         {
            _loc5_ = 240;
            _loc8_ = 570;
            _loc11_.ty = (_loc8_ + _loc5_) * 0.5 - 400;
            _loc11_.d = (_loc8_ - _loc5_) / 100;
         }
         var _loc9_:OnceEffectAnimationFactory = OnceEffectAnimationFactory.factory(scene,_loc6_,_loc11_,timeOffset,null,false);
         _loc9_.createOnScene(scene.sortedContainer,_loc10_);
      }
   }
}
