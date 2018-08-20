package game.view.gui.tutorial.dialogs
{
   import engine.core.clipgui.ClipSprite;
   import feathers.controls.Label;
   import feathers.controls.LayoutGroup;
   import flash.geom.Point;
   import flash.geom.Rectangle;
   import flash.utils.Dictionary;
   import game.assets.storage.AssetStorage;
   import game.stat.Stash;
   import game.view.gui.components.GameButton;
   import game.view.gui.tutorial.ITutorialActionProvider;
   import game.view.gui.tutorial.ITutorialNodePresenter;
   import game.view.gui.tutorial.Tutorial;
   import game.view.gui.tutorial.TutorialActionsHolder;
   import game.view.gui.tutorial.TutorialLockOverlay;
   import game.view.gui.tutorial.TutorialNavigator;
   import game.view.gui.tutorial.TutorialNode;
   import game.view.gui.tutorial.tutorialtarget.TutorialTarget;
   import starling.display.DisplayObject;
   
   public class TutorialMessageLayer extends LayoutGroup implements ITutorialNodePresenter, ITutorialActionProvider
   {
      
      private static const ON_THE_RIGHT:int = 1;
      
      private static const BIG_ONE:int = 2;
      
      private static const BIG_ONE_X_SIZE:Number = 250;
      
      private static const ICON_SPEECH_BUBBLE:String = "speechBubble";
      
      private static const MESSAGE_BORDER:Number = 10;
       
      
      private var locker:TutorialLockOverlay;
      
      private var header:Label;
      
      private var text:Label;
      
      private var button:GameButton;
      
      private var iconCache:Dictionary;
      
      private var messages:Vector.<TutorialMessageClip>;
      
      private var message_left_bubble:TutorialMessageClip;
      
      private var currentMessage:TutorialMessageClip;
      
      private var currentMessageDescription:TutorialMessageEntry;
      
      private var relativePosition:Point;
      
      public function TutorialMessageLayer(param1:TutorialLockOverlay)
      {
         var _loc2_:int = 0;
         iconCache = new Dictionary();
         messages = new Vector.<TutorialMessageClip>();
         relativePosition = new Point();
         super();
         this.locker = param1;
         param1.targetUpdated.add(repositionCurrentMessage);
         _loc2_ = 0;
         while(_loc2_ <= (2 | 1))
         {
            messages[_loc2_] = AssetStorage.rsx.dialog_tutorial.create_tutorialMessage(_loc2_ & 1,_loc2_ & 2);
            messages[_loc2_].button_ok.initialize("OK",onButtonPressed);
            _loc2_++;
         }
         message_left_bubble = AssetStorage.rsx.dialog_tutorial.create_tutorialMessageBubble();
         message_left_bubble.button_ok.initialize("OK",onButtonPressed);
      }
      
      public function get tutorialNode() : TutorialNode
      {
         return TutorialNavigator.TUTORIAL_MESSAGE;
      }
      
      public function registerTutorial(param1:TutorialTarget) : TutorialActionsHolder
      {
         var _loc2_:TutorialActionsHolder = TutorialActionsHolder.create(this);
         _loc2_.addCloseButton(button);
         return _loc2_;
      }
      
      public function hide() : void
      {
         if(currentMessageDescription)
         {
            Stash.closeTutorialMessage(currentMessageDescription.id);
            currentMessageDescription = null;
         }
         parent.removeChild(this);
      }
      
      public function applyMessage(param1:TutorialMessageEntry) : void
      {
         var _loc3_:* = null;
         var _loc4_:* = 0;
         var _loc5_:* = null;
         resolveRelativePosition(bounds,param1.position,relativePosition);
         var _loc2_:String = param1.icon;
         if(!iconCache[_loc2_])
         {
            var _loc6_:* = AssetStorage.rsx.dialog_tutorial.getIcon(_loc2_);
            iconCache[_loc2_] = _loc6_;
            _loc3_ = _loc6_;
         }
         else
         {
            _loc3_ = iconCache[_loc2_];
         }
         if(param1.icon == "speechBubble")
         {
            _loc5_ = message_left_bubble;
         }
         else
         {
            _loc4_ = (relativePosition.x > 0.5?1:0) | (_loc3_.graphics.width > 250?2:0);
            _loc5_ = messages[_loc4_];
         }
         if(currentMessage)
         {
            currentMessage.icon_container.container.removeChildren();
         }
         if(_loc5_ != currentMessage)
         {
            if(currentMessage)
            {
               removeChild(currentMessage.graphics);
            }
            currentMessage = _loc5_;
            addChild(currentMessage.graphics);
         }
         if(_loc3_)
         {
            _loc3_.graphics.scaleX = relativePosition.x > 0.5?-1:1;
            currentMessage.icon_container.container.addChild(_loc3_.graphics);
         }
         if(currentMessageDescription)
         {
            Stash.closeTutorialMessage(currentMessageDescription.id);
         }
         currentMessageDescription = param1;
         if(currentMessageDescription)
         {
            Stash.openTutorialMessage(currentMessageDescription.id);
         }
         currentMessage.animateText(param1.text);
         currentMessage.button_ok.graphics.visible = param1.needButton;
         repositionCurrentMessage();
      }
      
      public function onButtonPressed() : void
      {
         Tutorial.events.triggerEvent_tutorialOk();
      }
      
      protected function repositionCurrentMessage() : void
      {
         var _loc3_:* = null;
         if(!currentMessage || !currentMessage.graphics.stage)
         {
            return;
         }
         currentMessage.tf_text.validate();
         var _loc4_:DisplayObject = currentMessage.graphics;
         if(currentMessage.panel.graphics)
         {
            _loc3_ = currentMessage.panel.graphics.getBounds(parent);
         }
         else
         {
            _loc3_ = currentMessage.graphics.getBounds(parent);
         }
         _loc3_.inflate(10,10);
         var _loc2_:Rectangle = bounds;
         _loc3_.x = int((_loc2_.width - _loc3_.width) * relativePosition.x + 10);
         _loc3_.y = int((_loc2_.height - _loc3_.height) * relativePosition.y + 10);
         var _loc1_:Rectangle = locker.getTargetBounds();
         if(_loc1_ && _loc3_.intersects(_loc1_))
         {
            solveIntersection(_loc3_,_loc1_);
         }
         _loc4_.x = _loc3_.x;
         _loc4_.y = _loc3_.y;
      }
      
      protected function resolveRelativePosition(param1:Rectangle, param2:String, param3:Point) : void
      {
         var _loc6_:* = NaN;
         var _loc5_:* = NaN;
         var _loc4_:* = null;
         if(param2 && param2.indexOf(",") != -1)
         {
            _loc4_ = param2.split(",");
            if(_loc4_[0].indexOf("%") != -1)
            {
               _loc6_ = Number(int(_loc4_[0].slice(0,_loc4_[0].indexOf("%"))) / 100);
            }
            else
            {
               _loc6_ = Number(_loc4_[0] / param1.width);
            }
            if(_loc4_[1].indexOf("%") != -1)
            {
               _loc5_ = Number(int(_loc4_[1].slice(0,_loc4_[1].indexOf("%"))) / 100);
            }
            else
            {
               _loc5_ = Number(_loc4_[1] / param1.width);
            }
         }
         else if(param2)
         {
            if(param2.indexOf("top") != -1)
            {
               _loc5_ = 0;
            }
            else if(param2.indexOf("bottom") != -1)
            {
               _loc5_ = 1;
            }
            else
            {
               _loc5_ = 0.5;
            }
            if(param2.indexOf("left") != -1)
            {
               _loc6_ = 0;
            }
            else if(param2.indexOf("right") != -1)
            {
               _loc6_ = 1;
            }
            else
            {
               _loc6_ = 0.5;
            }
         }
         else
         {
            _loc5_ = Number(0.5);
            _loc6_ = Number(0.5);
         }
         param3.x = _loc6_;
         param3.y = _loc5_;
      }
      
      protected function solveIntersection(param1:Rectangle, param2:Rectangle) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = tryResolveAxisIntersection(param1.y,param1.height,param2.y,param2.height,10,height - 10);
         if(_loc4_ != 0)
         {
            param1.y = param1.y + _loc4_;
         }
         else
         {
            _loc3_ = tryResolveAxisIntersection(param1.x,param1.width,param2.x,param2.width,10,width - 10);
            if(_loc3_ != 0)
            {
               param1.x = param1.x + _loc3_;
            }
         }
      }
      
      protected function tryResolveAxisIntersection(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number) : Number
      {
         var _loc8_:Number = param3 - param1 - param2;
         if(param1 + _loc8_ >= param5)
         {
            return _loc8_;
         }
         var _loc7_:Number = param3 + param4 - param1;
         if(param1 + param2 + _loc7_ <= param6)
         {
            return _loc7_;
         }
         return 0;
      }
   }
}
