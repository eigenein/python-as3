package game.mediator.gui.popup.billing.bundle
{
   import engine.core.clipgui.IGuiClip;
   import feathers.data.ListCollection;
   import feathers.layout.HorizontalLayout;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   import starling.events.Event;
   
   public class BundleIconList extends GameScrolledAlphaGradientList implements IGuiClip
   {
      
      public static const SCROLL_DURATION:Number = 0.25;
      
      public static const DISABLED_AROWS_ALPHA:Number = 0.5;
      
      private static const ITEM_DEFAULT_WIDTH:int = 84;
      
      private static const SIDE_PADDINGS:Number = 4;
      
      private static const ITEMS_GAP:Number = 6;
      
      private static const ITEMS_IN_PAGE_MAX:int = 7;
       
      
      private var button_left:ClipButton;
      
      private var button_right:ClipButton;
      
      private var parentClipLayout:ClipLayout;
      
      public function BundleIconList(param1:ClipLayout, param2:ClipButton, param3:ClipButton)
      {
         super(null,20,true);
         this.button_right = param3;
         this.button_left = param2;
         this.parentClipLayout = param1;
         addEventListener("change",handler_selected);
      }
      
      override public function set selectedItem(param1:Object) : void
      {
         .super.selectedItem = param1;
         scrollToDisplayIndex(selectedIndex,0.25);
      }
      
      override public function set dataProvider(param1:ListCollection) : void
      {
         .super.dataProvider = param1;
         if(!param1)
         {
            return;
         }
         if(dataProvider.length <= 7)
         {
            width = NaN;
            button_left.graphics.visible = false;
            button_right.graphics.visible = false;
            parentClipLayout.addChild(this);
         }
         else
         {
            width = 632;
            parentClipLayout.addChild(button_left.graphics);
            button_left.signal_click.add(scrollLeft);
            parentClipLayout.addChild(this);
            parentClipLayout.addChild(button_right.graphics);
            button_right.signal_click.add(scrollRight);
         }
      }
      
      override protected function refreshExternalScrollElements() : void
      {
         super.refreshExternalScrollElements();
         var _loc2_:* = !isLeftMostPosition;
         button_left.isEnabled = _loc2_;
         button_left.graphics.alpha = !!_loc2_?1:0.5;
         var _loc1_:* = !isRightMostPosition;
         button_right.isEnabled = _loc1_;
         button_right.graphics.alpha = !!_loc1_?1:0.5;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.verticalAlign = "middle";
         layout = _loc1_;
         _loc1_.gap = 6;
         var _loc2_:int = 4;
         _loc1_.paddingRight = _loc2_;
         _loc1_.paddingLeft = _loc2_;
         itemRendererType = BundleIconListItemRendered;
         throwEase = "easeInOut";
         snapToPages = true;
         verticalScrollPolicy = "off";
         horizontalScrollPolicy = "on";
         interactionMode = "mouse";
      }
      
      public function scrollRight() : void
      {
         var _loc1_:Number = horizontalScrollPosition + actualPageWidth;
         scrollToPosition(_loc1_ > maxHorizontalScrollPosition?maxHorizontalScrollPosition:Number(_loc1_),NaN,0.25);
      }
      
      public function scrollLeft() : void
      {
         var _loc1_:Number = horizontalScrollPosition - actualPageWidth;
         scrollToPosition(_loc1_ < minHorizontalScrollPosition?minHorizontalScrollPosition:Number(_loc1_),NaN,0.25);
      }
      
      private function handler_selected(param1:Event) : void
      {
         scrollToDisplayIndex(selectedIndex,0.25);
      }
   }
}
