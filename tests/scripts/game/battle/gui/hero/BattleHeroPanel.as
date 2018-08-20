package game.battle.gui.hero
{
   import battle.data.BattleHeroDescription;
   import battle.proxy.CustomManualAction;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.AnchorLayout;
   import game.assets.storage.AssetStorage;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.data.storage.enum.lib.HeroColor;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.mediator.gui.popup.titan.TitanEntryValueObject;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.display.Image;
   import starling.filters.ColorMatrixFilter;
   
   public class BattleHeroPanel implements ITutorialActionProvider
   {
       
      
      protected var desc:BattleHeroDescription;
      
      private var mediator:BattleHeroControllerWithPanel;
      
      private var _enabled:Boolean = false;
      
      private var _dead:Boolean = false;
      
      private var heroPortrait:Image;
      
      private var heroFrame:Image;
      
      private var heroBackground:Image;
      
      private var portrait_asset:BattleGUIHeroPortrait;
      
      private var fullEnergy:Boolean;
      
      private var actionAvailable:Boolean;
      
      private var actionAnimations:Vector.<GuiAnimation>;
      
      private var actions:Vector.<CustomManualAction>;
      
      public const frontGraphics:LayoutGroup = new LayoutGroup();
      
      public const backGraphics:BattleGUIHeroPanelGlowAnimation = new BattleGUIHeroPanelGlowAnimation();
      
      public function BattleHeroPanel()
      {
         actionAnimations = new Vector.<GuiAnimation>();
         actions = new Vector.<CustomManualAction>();
         super();
      }
      
      public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
         var _loc4_:int = 0;
         var _loc3_:* = actionAnimations;
         for each(var _loc1_ in actionAnimations)
         {
            _loc1_.dispose();
         }
         var _loc6_:int = 0;
         var _loc5_:* = actions;
         for each(var _loc2_ in actions)
         {
            _loc2_.condition.onDisable.removeAll();
            _loc2_.condition.onEnable.removeAll();
         }
      }
      
      public function set data(param1:BattleHeroControllerWithPanel) : void
      {
         createClip(param1.getHeroEntryValueObject() is TitanEntryValueObject);
         if(mediator)
         {
            mediator.onUpdateUserActionAvailable.remove(handler_userActionAvailable);
            mediator.onUpdateEnergy.remove(handler_energyUpdate);
            mediator.onUpdateHp.remove(handler_hpUpdate);
            mediator.onDead.remove(handler_dead);
            var _loc5_:int = 0;
            var _loc4_:* = actions;
            for each(var _loc2_ in actions)
            {
               _loc2_.condition.onDisable.removeAll();
               _loc2_.condition.onEnable.removeAll();
               frontGraphics.removeChild(portrait_asset.graphics);
               frontGraphics.removeChildren(0,-1,true);
               frontGraphics.addChild(portrait_asset.graphics);
            }
            actions.length = 0;
         }
         this.mediator = param1;
         var _loc3_:UnitEntryValueObject = mediator.getHeroEntryValueObject();
         portrait_asset.portrait.frame.image.texture = _loc3_.qualityFrame;
         portrait_asset.portrait.bg.image.texture = _loc3_.qualityBackground;
         portrait_asset.portrait.portrait.image.texture = _loc3_.icon;
         mediator.onUpdateUserActionAvailable.add(handler_userActionAvailable);
         mediator.onUpdateEnergy.add(handler_energyUpdate);
         mediator.onUpdateHp.add(handler_hpUpdate);
         mediator.onDead.add(handler_dead);
         handler_userActionAvailable();
         handler_energyUpdate();
         handler_hpUpdate();
         Tutorial.addActionsFrom(this);
      }
      
      public function get battleOrder() : int
      {
         return mediator.hero.desc.battleOrder * mediator.hero.team.direction;
      }
      
      public function set enabled(param1:Boolean) : void
      {
         if(_enabled == param1)
         {
            return;
         }
         _enabled = param1;
         handler_userActionAvailable();
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(frontGraphics);
         if(actionAvailable)
         {
            _loc2_.addButton(TutorialNavigator.ACTION_BATTLE_HERO,portrait_asset.portrait);
         }
         return _loc2_;
      }
      
      public function addCustomManualAction(param1:CustomManualAction) : void
      {
         action = param1;
         actions.push(action);
         var g:GuiAnimation = new GuiAnimation();
         AssetStorage.rsx.battle_interface.initGuiClip(g,action.fx);
         g.graphics.touchable = false;
         actionAnimations.push(g);
         if(action.condition.isEnabled())
         {
            handler_userActionAvailable();
            frontGraphics.addChild(g.graphics);
         }
         action.condition.onEnable.add(function():void
         {
            handler_userActionAvailable();
            frontGraphics.addChild(g.graphics);
         });
         action.condition.onDisable.add(function():void
         {
            handler_userActionAvailable();
            frontGraphics.removeChild(g.graphics);
         });
      }
      
      protected function createClip(param1:Boolean) : void
      {
         if(portrait_asset)
         {
            return;
         }
         frontGraphics.layout = new AnchorLayout();
         frontGraphics.width = 96;
         frontGraphics.height = 106;
         if(param1)
         {
            portrait_asset = AssetStorage.rsx.battle_interface.create_portrait_titan();
         }
         else
         {
            portrait_asset = AssetStorage.rsx.battle_interface.create_portrait_hero();
         }
         portrait_asset.playback.stop();
         portrait_asset.ult_deactivate.hide();
         portrait_asset.ult_activate.hide();
         portrait_asset.ult_active.hide();
         portrait_asset.ult_full.hide();
         portrait_asset.ult_deactivate.graphics.touchable = false;
         portrait_asset.ult_activate.graphics.touchable = false;
         portrait_asset.ult_active.graphics.touchable = false;
         portrait_asset.ult_full.graphics.touchable = false;
         portrait_asset.progressbar_block_inst0.graphics.touchable = false;
         portrait_asset.portrait.signal_click.add(action_buttonTriggered);
         frontGraphics.addChild(portrait_asset.graphics);
         portrait_asset.portrait.bg.graphics.touchable = false;
         portrait_asset.portrait.portrait.graphics.touchable = false;
         portrait_asset.portrait.bg.image.texture = HeroColor.defaultBackgroundAsset;
         portrait_asset.portrait.portrait.image.texture = AssetStorage.rsx.missing;
         portrait_asset.portrait.frame.image.texture = HeroColor.defaultFrameAsset;
         backGraphics.includeInLayout = false;
      }
      
      private function canUseUlt() : Boolean
      {
         return mediator.userActionAvailable && _enabled && !_dead;
      }
      
      private function canUseButton() : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc4_:int = 0;
         var _loc3_:* = actions;
         for each(var _loc1_ in actions)
         {
            if(_loc1_.condition.enabled)
            {
               _loc2_ = true;
               break;
            }
         }
         return _loc2_ && _enabled && !_dead || canUseUlt();
      }
      
      private function canGlowPassive() : Boolean
      {
         var _loc1_:Boolean = fullEnergy && mediator.canGlow;
         return (actionAvailable || _loc1_) && !_dead;
      }
      
      private function handler_userActionAvailable() : void
      {
         if(!mediator)
         {
            return;
         }
         portrait_asset.setState(canUseButton(),canUseUlt(),canGlowPassive());
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_energyUpdate() : void
      {
         if(!mediator)
         {
            return;
         }
         var _loc1_:Number = mediator.energy;
         portrait_asset.progressbar_block_inst0.energy = _loc1_;
         var _loc2_:* = _loc1_ == 1;
         if(_loc2_ != fullEnergy)
         {
            fullEnergy = _loc2_;
            handler_userActionAvailable();
         }
      }
      
      private function handler_hpUpdate() : void
      {
         if(!mediator)
         {
            return;
         }
         portrait_asset.progressbar_block_inst0.hp = mediator.hp;
      }
      
      private function handler_dead() : void
      {
         if(!mediator)
         {
            return;
         }
         _dead = true;
         portrait_asset.progressbar_block_inst0.energy = mediator.energy;
         portrait_asset.progressbar_block_inst0.hp = mediator.hp;
         handler_userActionAvailable();
         setDark();
      }
      
      protected function action_buttonTriggered() : void
      {
         var _loc1_:* = null;
         if(!mediator)
         {
            return;
         }
         var _loc4_:int = 0;
         var _loc3_:* = actions;
         for each(var _loc2_ in actions)
         {
            if(_loc2_.condition.enabled && !_dead)
            {
               _loc2_.manualTrigger();
               _loc1_ = new GuiAnimation();
               AssetStorage.rsx.battle_interface.initGuiClip(_loc1_,_loc2_.fx + "Activate");
               frontGraphics.addChild(_loc1_.graphics);
               _loc1_.graphics.touchable = false;
               _loc1_.playOnce();
               _loc1_.disposeWhenCompleted = true;
               portrait_asset.playback.gotoAndPlay(1);
               portrait_asset.playback.stopOnFrame(0);
               return;
            }
         }
         mediator.action_userInput();
         if(!_dead)
         {
            portrait_asset.ult_deactivate.show(portrait_asset.container);
            portrait_asset.ult_deactivate.playOnceAndHide();
            portrait_asset.playback.gotoAndPlay(1);
            portrait_asset.playback.stopOnFrame(0);
         }
      }
      
      private function setDark() : void
      {
         var _loc1_:* = 0.5;
         var _loc2_:Vector.<Number> = new <Number>[_loc1_,0,0,0,0,0,_loc1_,0,0,0,0,0,_loc1_,0,0,0,0,0,1,0];
         portrait_asset.portrait.graphics.filter = new ColorMatrixFilter(_loc2_);
      }
   }
}
