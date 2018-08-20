package game.view.popup.hero.consumable
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipScale9Image;
   import flash.utils.getTimer;
   import game.data.storage.hero.HeroDescription;
   import game.mediator.gui.popup.hero.PlayerHeroListValueObject;
   import game.view.gui.components.ClipListItem;
   import game.view.gui.components.GuiSubscriber;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import game.view.popup.common.CutePanelClipButton;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class HeroUseConsumableWithSelectorHeroBaseClipListItem extends ClipListItem implements ITutorialActionProvider
   {
       
      
      protected const subscriber:GuiSubscriber = new GuiSubscriber();
      
      protected var signals:HeroUseConsumableHeroSignals;
      
      protected var data:PlayerHeroListValueObject;
      
      protected var _flashingStartTime:Number;
      
      public var selection:GuiClipScale9Image;
      
      public var button_bg:CutePanelClipButton;
      
      private var _expTweenValue:int = 0;
      
      public function HeroUseConsumableWithSelectorHeroBaseClipListItem(param1:HeroUseConsumableHeroSignals)
      {
         super();
         this.signals = param1;
      }
      
      override public function dispose() : void
      {
         super.dispose();
         graphics.removeEventListener("enterFrame",handler_enterFrame);
         subscriber.dispose();
         Tutorial.removeActionsFrom(this);
      }
      
      public function get expTweenValue() : int
      {
         return _expTweenValue;
      }
      
      public function set expTweenValue(param1:int) : void
      {
         setExp(param1);
      }
      
      public function get heroDescription() : HeroDescription
      {
         if(data)
         {
            return data.hero;
         }
         return null;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(graphics);
         _loc2_.addButtonWithKey(TutorialNavigator.ACTION_HERO_USE_CONSUMABLE,button_bg,data.hero);
         return _loc2_;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         if(selection)
         {
            container.removeChild(selection.graphics);
            selection.graphics.touchable = false;
         }
      }
      
      override public function setData(param1:*) : void
      {
         var _loc2_:PlayerHeroListValueObject = param1 as PlayerHeroListValueObject;
         if(this.data == _loc2_)
         {
            return;
         }
         subscriber.clear();
         this.data = _loc2_;
         if(!_loc2_)
         {
            return;
         }
         Tutorial.addActionsFrom(this);
         setExp(_loc2_.exp);
         _loc2_.signal_updateExp.add(handler_updateExp);
         subscriber.add(_loc2_.signal_updateExp,handler_updateExp);
         subscriber.add(_loc2_.signal_updateLevel,handler_updateLevel);
         if(selection.graphics.parent)
         {
            selection.graphics.removeFromParent();
            graphics.removeEventListener("enterFrame",handler_enterFrame);
         }
         if(signals)
         {
            signals.onScreen.dispatch(this);
         }
      }
      
      public function animateSelection() : void
      {
         if(selection)
         {
            container.addChild(selection.graphics);
            selection.graphics.alpha = 1;
            _flashingStartTime = getTimer();
            graphics.addEventListener("enterFrame",handler_enterFrame);
         }
      }
      
      protected function setExp(param1:int) : void
      {
         _expTweenValue = param1;
      }
      
      private function handler_updateLevel() : void
      {
         if(signals)
         {
            signals.levelUp.dispatch(this);
         }
      }
      
      protected function handler_updateExp() : void
      {
         if(data)
         {
            Starling.juggler.tween(this,0.2,{"expTweenValue":data.exp});
         }
      }
      
      protected function handler_enterFrame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(selection)
         {
            _loc2_ = 3000;
            _loc5_ = (getTimer() - _flashingStartTime) / _loc2_;
            if(_loc5_ < 1)
            {
               _loc3_ = 1 - _loc5_;
               _loc4_ = (Math.sqrt(_loc5_) * 5 + _loc5_ * 5) * 3.14159265358979;
               selection.graphics.alpha = (1 - Math.cos(_loc4_)) * 0.5 * _loc3_;
            }
            else
            {
               selection.graphics.removeFromParent();
               graphics.removeEventListener("enterFrame",handler_enterFrame);
            }
         }
      }
      
      protected function handler_oneLevelCick() : void
      {
         if(signals && data)
         {
            signals.oneLevelClick.dispatch(data);
         }
      }
      
      protected function handler_bgClick() : void
      {
         if(signals && data)
         {
            signals.click.dispatch(data);
         }
      }
   }
}
