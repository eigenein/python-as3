package game.view.popup.common
{
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import game.mediator.gui.popup.billing.PopupSideBarMediator;
   import game.mediator.gui.popup.billing.SideBarBlockValueObject;
   import game.view.popup.PopupBase;
   import starling.animation.Tween;
   import starling.core.Starling;
   import starling.events.Event;
   
   public class PopupSideBar
   {
       
      
      private var popup:PopupBase;
      
      private var mediator:PopupSideBarMediator;
      
      protected var defaultPopupWidth:Number;
      
      protected var defaultPopupHeight:Number;
      
      public const graphics:LayoutGroup = new LayoutGroup();
      
      private var current:IPopupSideBarBlock;
      
      private var removedDelayed:Vector.<IPopupSideBarBlock>;
      
      private var offset:Number = 0;
      
      private var gap:Number = 0;
      
      private var side:PopupSideBarSide;
      
      public function PopupSideBar(param1:PopupBase, param2:PopupSideBarMediator = null)
      {
         removedDelayed = new Vector.<IPopupSideBarBlock>();
         super();
         this.popup = param1;
         graphics.layout = new HorizontalLayout();
         if(param2)
         {
            this.mediator = param2;
            param2.currentBlock.onValue(handler_sideBarBlock);
         }
      }
      
      public function dispose() : void
      {
         stopTweens();
         if(current)
         {
            current.graphics.removeFromParent(true);
            current.dispose();
         }
         if(mediator)
         {
            mediator.currentBlock.unsubscribe(handler_sideBarBlock);
         }
         handler_removeComplete();
      }
      
      public function setBlock(param1:IPopupSideBarBlock) : void
      {
         if(current == param1)
         {
            return;
         }
         if(current != null)
         {
            if(param1 != null)
            {
               current.graphics.removeFromParent(true);
               current.dispose();
            }
            else
            {
               current.graphics.touchable = false;
               removedDelayed.push(current);
               Starling.juggler.tween(graphics,0.6,{
                  "alpha":0,
                  "onComplete":handler_removeComplete
               }) as Tween;
               Starling.juggler.tween(popup,0.6,{
                  "width":defaultPopupWidth,
                  "height":defaultPopupHeight,
                  "transition":"easeInOut"
               }) as Tween;
               current = null;
            }
         }
         this.current = param1;
         if(param1)
         {
            handler_removeComplete();
            stopTweens();
            param1.initialize(popup.stashParams);
            graphics.addChild(param1.graphics);
            offset = param1.popupOffset;
            gap = param1.popupGap;
            side = param1.popupSide;
            graphics.addEventListener("resize",handler_resize);
            if(!popup.isCreated)
            {
               popup.addEventListener("creationComplete",handler_init);
            }
            else
            {
               handler_init(null);
            }
         }
      }
      
      protected function handler_init(param1:Event) : void
      {
         graphics.invalidate();
         graphics.validate();
         defaultPopupWidth = popup.width;
         defaultPopupHeight = popup.height;
         graphics.includeInLayout = false;
         if(side == PopupSideBarSide.left)
         {
            graphics.x = -graphics.width - gap;
            popup.width = popup.width - offset * 2;
         }
         else if(side == PopupSideBarSide.right)
         {
            graphics.x = popup.width + gap;
            popup.width = popup.width + offset * 2;
         }
         else if(side == PopupSideBarSide.top)
         {
            graphics.y = -graphics.height - gap;
            popup.height = popup.height - offset * 2;
         }
         else if(side == PopupSideBarSide.bottom)
         {
            graphics.y = popup.height + gap;
            popup.height = popup.height + offset * 2;
         }
         if(side == PopupSideBarSide.left || side == PopupSideBarSide.right)
         {
            graphics.height = popup.height;
            (graphics.layout as HorizontalLayout).verticalAlign = "middle";
         }
         else
         {
            graphics.width = popup.width;
            (graphics.layout as HorizontalLayout).horizontalAlign = "center";
         }
      }
      
      protected function handler_resize() : void
      {
      }
      
      private function stopTweens() : void
      {
         Starling.juggler.removeTweens(graphics);
         Starling.juggler.removeTweens(popup);
      }
      
      protected function handler_sideBarBlock(param1:SideBarBlockValueObject) : void
      {
         var _loc2_:* = null;
         if(param1 && param1 != SideBarBlockValueObject.EMPTY)
         {
            _loc2_ = param1.sideBarBlock;
            if(_loc2_)
            {
               setBlock(_loc2_);
            }
         }
         else
         {
            setBlock(null);
         }
      }
      
      private function handler_removeComplete() : void
      {
         var _loc3_:int = 0;
         var _loc2_:* = removedDelayed;
         for each(var _loc1_ in removedDelayed)
         {
            _loc1_.graphics.removeFromParent(true);
            _loc1_.dispose();
         }
         removedDelayed.length = 0;
      }
   }
}
