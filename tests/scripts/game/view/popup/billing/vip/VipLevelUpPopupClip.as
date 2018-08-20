package game.view.popup.billing.vip
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import engine.core.clipgui.GuiClipScale9Image;
   import feathers.layout.VerticalLayout;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipLayoutNone;
   import game.view.gui.components.ClipListWithScroll;
   import game.view.gui.components.GameScrollBar;
   import game.view.popup.billing.BillingVipLevelBlock;
   import game.view.popup.billing.ClipListItemVipBenefit;
   
   public class VipLevelUpPopupClip extends GuiClipNestedContainer
   {
       
      
      public var button_close:ClipButtonLabeled;
      
      public var tf_header:ClipLabel;
      
      private var scrollBar:GameScrollBar;
      
      public var benefit_list:ClipListWithScroll;
      
      public var benefit_item:ClipDataProvider;
      
      public var gradient_bottom:ClipSprite;
      
      public var gradient_top:ClipSprite;
      
      public var vip_word_header:ClipSprite;
      
      public var vip_level:BillingVipLevelBlock;
      
      public var scroll_slider_container:ClipLayoutNone;
      
      public var ribbon:GuiClipScale3Image;
      
      public var bg:GuiClipScale9Image;
      
      public var list_bg:GuiClipScale9Image;
      
      public var layout_header:ClipLayout;
      
      public var decorDivider_inst0:ClipSprite;
      
      public var decorDivider_inst1:ClipSprite;
      
      public var layout_vip_level:ClipLayout;
      
      public function VipLevelUpPopupClip()
      {
         button_close = new ClipButtonLabeled();
         tf_header = new ClipLabel(true);
         scrollBar = new GameScrollBar();
         benefit_list = new ClipListWithScroll(ClipListItemVipBenefit,scrollBar);
         benefit_item = benefit_list.itemClipProvider;
         gradient_bottom = new ClipSprite();
         gradient_top = new ClipSprite();
         vip_word_header = new ClipSprite();
         vip_level = new BillingVipLevelBlock();
         scroll_slider_container = new ClipLayoutNone();
         ribbon = new GuiClipScale3Image();
         bg = new GuiClipScale9Image();
         list_bg = new GuiClipScale9Image();
         layout_header = ClipLayout.horizontalMiddleCentered(4,tf_header,vip_word_header);
         decorDivider_inst0 = new ClipSprite();
         decorDivider_inst1 = new ClipSprite();
         layout_vip_level = ClipLayout.horizontalMiddleCentered(4,decorDivider_inst0,vip_level,decorDivider_inst1);
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
