package game.battle.gui.hero
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.controls.LayoutGroup;
   import game.battle.controller.hero.BattleHeroControllerWithPanel;
   import game.battle.gui.BattleGuiProgressbarBlockClip;
   import game.mediator.gui.popup.hero.UnitEntryValueObject;
   import game.view.gui.components.hero.MiniHeroPortraitClipWithLevel;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.display.DisplayObject;
   import starling.filters.ColorMatrixFilter;
   
   public class BattleHeroPanelClip extends GuiClipNestedContainer implements ITutorialActionProvider
   {
       
      
      private var _data:BattleHeroControllerWithPanel;
      
      private var _enabled:Boolean;
      
      private var _dead:Boolean;
      
      private var fullEnergy:Boolean;
      
      private var actionAvailable:Boolean;
      
      public var portrait:MiniHeroPortraitClipWithLevel;
      
      public var bars:BattleGuiProgressbarBlockClip;
      
      public var glow:ClipSpriteUntouchable;
      
      public const frontGraphics:LayoutGroup = new LayoutGroup();
      
      public const backGraphics:BattleGUIHeroPanelGlowAnimation = new BattleGUIHeroPanelGlowAnimation();
      
      public function BattleHeroPanelClip()
      {
         super();
      }
      
      public function dispose() : void
      {
         Tutorial.removeActionsFrom(this);
      }
      
      public function set data(param1:BattleHeroControllerWithPanel) : void
      {
         if(_data)
         {
            _data.onUpdateUserActionAvailable.remove(handler_userActionAvailable);
            _data.onUpdateEnergy.remove(handler_energyUpdate);
            _data.onUpdateHp.remove(handler_hpUpdate);
            _data.onDead.remove(handler_dead);
         }
         this._data = param1;
         var _loc2_:UnitEntryValueObject = _data.getHeroEntryValueObject();
         portrait.data = _loc2_;
         _data.onUpdateUserActionAvailable.add(handler_userActionAvailable);
         _data.onUpdateEnergy.add(handler_energyUpdate);
         _data.onUpdateHp.add(handler_hpUpdate);
         _data.onDead.add(handler_dead);
         handler_userActionAvailable();
         handler_energyUpdate();
         handler_hpUpdate();
         Tutorial.addActionsFrom(this);
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(frontGraphics);
         if(actionAvailable)
         {
            _loc2_.addButton(TutorialNavigator.ACTION_BATTLE_HERO,portrait);
         }
         return _loc2_;
      }
      
      public function get battleOrder() : int
      {
         return _data.hero.desc.battleOrder * _data.hero.team.direction;
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
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         frontGraphics.addChild(graphics);
         backGraphics.addChild(glow.graphics);
         frontGraphics.validate();
      }
      
      private function handler_userActionAvailable() : void
      {
         if(!_data)
         {
            return;
         }
         actionAvailable = _data.userActionAvailable && _enabled && !_dead;
         portrait.isEnabled = actionAvailable;
         var _loc1_:Boolean = (actionAvailable || fullEnergy) && !_dead;
         this.glow.graphics.visible = _loc1_;
         Tutorial.updateActionsFrom(this);
      }
      
      private function handler_energyUpdate() : void
      {
         if(!_data)
         {
            return;
         }
         var _loc1_:Number = _data.energy;
         bars.energy = _loc1_;
         var _loc2_:* = _loc1_ == 1;
         if(_loc2_ != fullEnergy)
         {
            fullEnergy = _loc2_;
            handler_userActionAvailable();
         }
      }
      
      private function handler_hpUpdate() : void
      {
         if(!_data)
         {
            return;
         }
         bars.hp = _data.hp;
      }
      
      private function handler_dead() : void
      {
         if(!_data)
         {
            return;
         }
         _dead = true;
         bars.energy = _data.energy;
         bars.hp = _data.hp;
         handler_userActionAvailable();
         setDark(true);
      }
      
      protected function action_buttonTriggered() : void
      {
         if(!_data)
         {
            return;
         }
         _data.action_userInput();
      }
      
      private function setDark(param1:Boolean) : void
      {
         var _loc2_:* = NaN;
         var _loc3_:* = undefined;
         if(param1)
         {
            _loc2_ = 0.4;
            _loc3_ = new <Number>[_loc2_,0,0,0,0,0,_loc2_,0,0,0,0,0,_loc2_,0,0,0,0,0,1,0];
            graphics.filter = new ColorMatrixFilter(_loc3_);
         }
         else if(graphics.filter)
         {
            graphics.filter.dispose();
            graphics.filter = null;
         }
         var _loc6_:DisplayObject = portrait.graphics;
         var _loc4_:Number = _loc6_.scaleX;
         var _loc5_:Number = !!param1?0.9:1;
      }
   }
}
