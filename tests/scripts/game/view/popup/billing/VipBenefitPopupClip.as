package game.view.popup.billing
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import engine.core.clipgui.GuiClipScale3Image;
   import feathers.layout.VerticalLayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   
   public class VipBenefitPopupClip extends PopupClipBase
   {
       
      
      private var scrollBar:GameScrollBar;
      
      public var button_to_store:ClipButtonLabeled;
      
      public var button_left:ClipButton;
      
      public var button_right:ClipButton;
      
      public var header_vip_level:BillingVipLevelBlock;
      
      public var left_vip_level:BillingVipLevelBlock;
      
      public var right_vip_level:BillingVipLevelBlock;
      
      public var selected_vip_level:BillingVipLevelBlock;
      
      public var tf_benefits:ClipLabel;
      
      public var layout_vip_header:ClipLayout;
      
      public var layout_vip_selected:ClipLayout;
      
      public var layout_vip_left:ClipLayout;
      
      public var layout_vip_right:ClipLayout;
      
      public var gradient_top:ClipSpriteUntouchable;
      
      public var gradient_bottom:ClipSpriteUntouchable;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var benefit_list:ClipListWithScroll;
      
      public var benefit_item:ClipDataProvider;
      
      public var tf_progress_value:ClipLabel;
      
      public var progress_bar:GuiClipScale3Image;
      
      public var progress_bg:GuiClipScale3Image;
      
      public var block_points_needed:BillingNeedVipPointsClip;
      
      public var drape1:ClipSpriteUntouchable;
      
      public var drape2:ClipSpriteUntouchable;
      
      public var drape3:ClipSpriteUntouchable;
      
      public var drape4:ClipSpriteUntouchable;
      
      public function VipBenefitPopupClip()
      {
         scrollBar = new GameScrollBar();
         header_vip_level = new BillingVipLevelBlock();
         left_vip_level = new BillingVipLevelBlock();
         right_vip_level = new BillingVipLevelBlock();
         selected_vip_level = new BillingVipLevelBlock();
         tf_benefits = new ClipLabel(true);
         layout_vip_header = ClipLayout.horizontalCentered(0,header_vip_level);
         layout_vip_selected = ClipLayout.horizontalMiddleCentered(5,selected_vip_level,tf_benefits);
         layout_vip_left = ClipLayout.horizontalCentered(0,left_vip_level);
         layout_vip_right = ClipLayout.horizontalCentered(0,right_vip_level);
         scroll_slider_container = new ClipLayoutNone();
         benefit_list = new ClipListWithScroll(ClipListItemVipBenefit,scrollBar);
         benefit_item = benefit_list.itemClipProvider;
         block_points_needed = new BillingNeedVipPointsClip();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         var _loc2_:VerticalLayout = new VerticalLayout();
         benefit_list.list.layout = _loc2_;
         _loc2_.useVirtualLayout = false;
         _loc2_.paddingBottom = 10;
         scrollBar.height = scroll_slider_container.height;
         scroll_slider_container.addChild(scrollBar);
         benefit_list.addGradients(gradient_top.graphics,gradient_bottom.graphics);
      }
   }
}
