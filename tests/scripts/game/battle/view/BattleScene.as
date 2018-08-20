package game.battle.view
{
   import battle.data.BattleHeroDescription;
   import battle.data.BattleSkillDescription;
   import engine.core.animation.ZSortedSprite;
   import flash.utils.Dictionary;
   import game.assets.battle.BattleAsset;
   import game.battle.controller.BattleSoundConfig;
   import game.battle.controller.entities.BattleHero;
   import game.battle.controller.position.HeroViewPositionValue;
   import game.battle.view.hero.HeroTeamTravelManager;
   import game.battle.view.hero.HeroView;
   import game.battle.view.hero.HeroViewContainer;
   import game.battle.view.location.BattlegroundController;
   import game.battle.view.systems.BattleSkillFxSystem;
   import game.battle.view.systems.BattleViewSystemSpace;
   import game.battle.view.systems.IBattleDisposable;
   import game.battle.view.text.BattleTextAnimationController;
   import game.battle.view.ult.UltAnimationController;
   import idv.cjcat.signals.Signal;
   
   public class BattleScene extends HeroViewContainer
   {
      
      public static const Y_CENTER:Number = 400;
       
      
      public const graphics:ZSortedSprite = new ZSortedSprite();
      
      public const ultController:UltAnimationController = new UltAnimationController();
      
      public const textController:BattleTextAnimationController = new BattleTextAnimationController();
      
      public const shakeController:BattleScreenShakeController = new BattleScreenShakeController();
      
      public const layers:BattleSceneLayers = new BattleSceneLayers();
      
      public const postProcessing:BattleScenePostprocessing = new BattleScenePostprocessing(graphics);
      
      const heroDescMapping:Dictionary = new Dictionary();
      
      private var deadHeroes:Vector.<HeroView>;
      
      private var freezeDurationLeft:Number = 0;
      
      private var systems:BattleViewSystemSpace;
      
      private var currentBattleFadableAnimations:BattleFadableAnimations;
      
      private var skillAnimations:BattleSkillFxSystem;
      
      private const sounds:BattleSounds = new BattleSounds();
      
      private const traveler:HeroTeamTravelManager = new HeroTeamTravelManager();
      
      public const camera:BattleSceneCameraController = new BattleSceneCameraController();
      
      public const battlegroundController:BattlegroundController = new BattlegroundController(this);
      
      public function BattleScene(param1:BattleSoundConfig = null)
      {
         deadHeroes = new Vector.<HeroView>();
         systems = new BattleViewSystemSpace();
         currentBattleFadableAnimations = new BattleFadableAnimations();
         skillAnimations = new BattleSkillFxSystem(ultController);
         super();
         sounds.setSoundConfig(param1);
         sounds.listenForSoundsFromGraphics(graphics);
         initGraphics();
         initSystems();
         ultController.init(heroesContainer,graphics,scale,this);
         graphics.addChild(ultController.graphics);
      }
      
      public function dispose() : void
      {
         sounds.dispose();
         var _loc4_:int = 0;
         var _loc3_:* = heroDescMapping;
         for(var _loc2_ in heroDescMapping)
         {
            heroDescMapping[_loc2_].dispose();
            delete heroDescMapping[_loc2_];
         }
         var _loc6_:int = 0;
         var _loc5_:* = deadHeroes;
         for each(var _loc1_ in deadHeroes)
         {
            _loc1_.dispose();
         }
         battlegroundController.dispose();
         textController.dispose();
         graphics.removeChildren(0,-1,true);
         postProcessing.dispose();
         if(graphics.parent)
         {
            graphics.parent.removeChild(graphics);
         }
         graphics.dispose();
      }
      
      public function get animationTarget() : ZSortedSprite
      {
         return heroesContainer;
      }
      
      public function get timeScale() : Number
      {
         return !!ultController.timeStopped?0:1;
      }
      
      public function get sortedContainer() : ZSortedSprite
      {
         return heroesContainer;
      }
      
      public function get canBattle() : Boolean
      {
         return !camera.inMotion;
      }
      
      public function get cameraMotionTimeLeft() : Number
      {
         return camera.motionTimeLeft;
      }
      
      public function get signal_travelComplete() : Signal
      {
         return camera.signal_travelComplete;
      }
      
      public function freezeScreen(param1:Number) : void
      {
         freezeDurationLeft = Math.max(param1,freezeDurationLeft);
      }
      
      public function getTimeDelta(param1:Number) : Number
      {
         if(freezeDurationLeft > 0)
         {
            if(freezeDurationLeft > param1)
            {
               freezeDurationLeft = freezeDurationLeft - param1;
               return 0;
            }
            param1 = param1 - freezeDurationLeft;
            freezeDurationLeft = 0;
            return param1;
         }
         return param1;
      }
      
      public function addHeroView(param1:BattleHeroDescription, param2:HeroView) : void
      {
         addHero(param2);
         camera.addHeroToTracking(param2);
         layers.statusContainer.addChild(param2.statusBar.graphics);
         if(param1 != null)
         {
            heroDescMapping[param1] = param2;
         }
      }
      
      public function setHeroCameraTracking(param1:HeroView, param2:Boolean) : void
      {
         if(param2)
         {
            camera.addHeroToTracking(param1);
         }
         else
         {
            camera.removeHeroFromTracking(param1);
         }
      }
      
      public function getHeroView(param1:BattleHeroDescription) : HeroView
      {
         return heroDescMapping[param1];
      }
      
      public function freeHeroView(param1:BattleHeroDescription) : void
      {
         var _loc2_:* = null;
         if(heroDescMapping[param1])
         {
            _loc2_ = heroDescMapping[param1];
            deadHeroes.push(_loc2_);
            camera.removeHeroFromTracking(_loc2_);
            delete heroDescMapping[param1];
         }
      }
      
      public function getTerrainHeight(param1:Number, param2:Number) : Number
      {
         /*
          * Decompilation error
          * Code may be obfuscated
          * Tip: You can try enabling "Automatic deobfuscation" in Settings
          * Error type: ArrayIndexOutOfBoundsException (null)
          */
         throw new flash.errors.IllegalOperationError("Not decompiled due to error");
      }
      
      public function initSystems() : void
      {
         systems.addSystem(currentBattleFadableAnimations);
         systems.addSystem(skillAnimations);
      }
      
      public function addFx(param1:IBattleDisposable, param2:BattleSkillDescription = null, param3:Boolean = false) : void
      {
         var _loc4_:BattleSceneObject = new BattleSceneObject(param1);
         _loc4_.skill = param2;
         _loc4_.tickOnPause = param3;
         addFxObject(_loc4_);
      }
      
      public function addFxObject(param1:BattleSceneObject) : void
      {
         param1.scene = this;
         systems.add(param1);
      }
      
      public function removeFxObject(param1:BattleSceneObject) : void
      {
         systems.remove(param1);
      }
      
      public function endBattle() : void
      {
         currentBattleFadableAnimations.endBattle();
      }
      
      public function cleanUpBattle() : void
      {
         currentBattleFadableAnimations.cleanUpBattle();
      }
      
      public function advanceTime(param1:Number) : void
      {
         postProcessing.update();
         var _loc2_:Number = param1 * timeScale;
         camera.advanceTime(_loc2_);
         battlegroundController.advanceTime(_loc2_);
         heroesContainer.transformationMatrix = camera.cameraTransform;
         layers.statusContainer.transformationMatrix = camera.cameraTransform;
         shakeController.advanceTime(param1);
         ultController.advanceTime(param1);
         systems.advanceTime(param1);
         advanceHeroesTime(_loc2_);
         textController.advanceTime(_loc2_);
      }
      
      public function prepareForBattle(param1:BattleAsset, param2:Vector.<BattleHero>) : void
      {
         sounds.updateSoundtrack(param1.getSoundtrack());
         battlegroundController.setBattlegroundAsset(param1.getSceneAsset());
         if(!traveler.isFirstBattle)
         {
            battlegroundController.nextBattle();
         }
         camera.setCurrentBattlePosition(battlegroundController.battlePosition,param1.battleConfig.leftBattleBorder,param1.battleConfig.rightBattleBorder);
         traveler.initConfig(param1.battleConfig);
         traveler.enterBattle(param2,battlegroundController.previousBattleOffset);
         var _loc3_:Number = traveler.maxTravelTime;
         camera.lockForDuration(_loc3_ * 0.25);
         camera.moveToPosition(battlegroundController.battlePosition,_loc3_ * 0.75);
         camera.signal_travelComplete.add(handler_cameraMovementComplete);
      }
      
      public function whenAllBattlesCompleted() : void
      {
         sounds.musicFadeAway();
      }
      
      public function setBlur() : void
      {
         postProcessing.setBlur();
      }
      
      protected function initGraphics() : void
      {
         var _loc2_:int = 0;
         graphics.y = 400;
         var _loc3_:* = scale;
         graphics.scaleY = _loc3_;
         graphics.scaleX = _loc3_;
         graphics.addChild(layers.background);
         heroesContainer.addChild(ultController.back);
         graphics.addChild(heroesContainer);
         graphics.addChild(layers.statusContainer);
         graphics.addChild(layers.foreground);
         graphics.addChild(textController.container);
         var _loc1_:int = graphics.numChildren;
         _loc2_ = 0;
         while(_loc2_ < _loc1_)
         {
            _loc2_++;
         }
         heroesContainer.touchable = false;
         layers.statusContainer.touchable = true;
         shakeController.setDisplayObject(graphics);
      }
      
      private function removeDeadHeroes() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = deadHeroes;
         for each(var _loc1_ in deadHeroes)
         {
            removeHero(_loc1_);
            _loc1_.dispose();
         }
         deadHeroes.length = 0;
      }
      
      private function handler_cameraMovementComplete() : void
      {
         removeDeadHeroes();
         traveler.stopTravel();
         camera.lockForDuration(2);
         camera.doTrackHeroes = true;
      }
   }
}
