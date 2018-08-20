package game.mechanics.expedition.popup
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.utils.MathUtil;
   import feathers.layout.HorizontalLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.expedition.model.SubscriptionLevelValueObject;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.GameScrolledAlphaGradientList;
   import game.view.gui.components.GameScrolledList;
   import starling.events.Event;
   
   public class SubscriptionLevelListClip extends GuiClipNestedContainer
   {
       
      
      public var button_left:ClipButton;
      
      public var button_right:ClipButton;
      
      public var list:GameScrolledAlphaGradientList;
      
      public var list_frame:GameScrolledList;
      
      public function SubscriptionLevelListClip()
      {
         button_left = new ClipButton();
         button_right = new ClipButton();
         list = new GameScrolledAlphaGradientList(null,80,true);
         list_frame = new GameScrolledList(null,null,null);
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc3_:HorizontalLayout = new HorizontalLayout();
         _loc3_.gap = -4;
         var _loc4_:int = -6;
         _loc3_.paddingRight = _loc4_;
         _loc3_.paddingLeft = _loc4_;
         list.layout = _loc3_;
         list.snapScrollPositionsToPixels = true;
         list.snapToPages = true;
         list.itemRendererType = SubscriptionPopupListRenderer;
         button_left.signal_click.add(handler_left);
         button_right.signal_click.add(handler_right);
         var _loc2_:SubscriptionPopupListRendererClip = new SubscriptionPopupListRendererClip();
         AssetStorage.rsx.dialog_artifact_subscription.initGuiClip(_loc2_,"subscription_level_renderer");
         list.pageWidth = _loc2_.frame.graphics.width + _loc3_.gap;
         list.addEventListener("scroll",handler_scroll);
         _loc3_ = new HorizontalLayout();
         _loc3_.gap = -4;
         list_frame.layout = _loc3_;
         list_frame.snapScrollPositionsToPixels = true;
         list_frame.snapToPages = true;
         list_frame.itemRendererType = SubscriptionPopupFrameListRenderer;
         list_frame.touchable = false;
      }
      
      public function scrollTo(param1:int) : void
      {
         list.validate();
         var _loc3_:Number = list.maxHorizontalScrollPosition - list.minHorizontalScrollPosition;
         var _loc4_:int = Math.ceil(_loc3_ / list.pageWidth) + 1;
         var _loc2_:int = param1 - (list.dataProvider.getItemAt(0) as SubscriptionLevelValueObject).level.level - int(list.width / list.pageWidth * 0.5);
         list.scrollToPageIndex(MathUtil.clamp(_loc2_,0,_loc4_ - 1),0.3);
      }
      
      private function handler_scroll(param1:Event) : void
      {
         var _loc3_:* = NaN;
         var _loc6_:SubscriptionLevelValueObject = list.dataProvider.getItemAt(0) as SubscriptionLevelValueObject;
         var _loc2_:int = _loc6_.currentLevel - _loc6_.level.level;
         list_frame.horizontalScrollPosition = list.horizontalScrollPosition;
         var _loc4_:Number = list.horizontalScrollPosition / list.pageWidth;
         var _loc5_:Number = (list.horizontalScrollPosition + list.width - (list.layout as HorizontalLayout).paddingLeft - (list.layout as HorizontalLayout).paddingRight) / list.pageWidth - 1;
         if(_loc4_ > _loc2_)
         {
            _loc3_ = Number(_loc4_ - _loc2_);
         }
         else if(_loc5_ < _loc2_)
         {
            _loc3_ = Number(_loc2_ - _loc5_);
         }
         else
         {
            _loc3_ = 0;
         }
         list_frame.alpha = Math.pow(1 - _loc3_,7);
      }
      
      private function handler_left() : void
      {
         tryScrollToPageIndex(list.horizontalPageIndex - 1);
      }
      
      private function handler_right() : void
      {
         tryScrollToPageIndex(list.horizontalPageIndex + 1);
      }
      
      private function tryScrollToPageIndex(param1:int) : void
      {
         var _loc3_:Number = list.maxHorizontalScrollPosition - list.minHorizontalScrollPosition;
         var _loc2_:int = Math.round(_loc3_ / list.pageWidth);
         list.scrollToPageIndex(MathUtil.clamp(param1,0,_loc2_),0.3);
      }
   }
}
