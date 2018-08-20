package game.view.popup.billing
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import feathers.controls.LayoutGroup;
   import feathers.layout.HorizontalLayout;
   import feathers.layout.VerticalLayout;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipDataProvider;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.ClipList;
   
   public class BillingConfirmPopupClip extends PopupClipBase
   {
       
      
      public var layout:LayoutGroup;
      
      public var button_confirm:ClipButtonLabeled;
      
      public var tf_buy:ClipLabel;
      
      public var tf_gem_value:ClipLabel;
      
      public var tf_question:ClipLabel;
      
      public var icon_gem:ClipSprite;
      
      public var layout_header:ClipLayout;
      
      public var tf_you_got:ClipLabel;
      
      public var list:ClipList;
      
      public var item:ClipDataProvider;
      
      public function BillingConfirmPopupClip()
      {
         tf_buy = new ClipLabel(true);
         tf_gem_value = new ClipLabel(true);
         tf_question = new ClipLabel(true);
         icon_gem = new ClipSprite();
         layout_header = ClipLayout.horizontalMiddleCentered(3,tf_buy,icon_gem,tf_gem_value,tf_question);
         tf_you_got = new ClipLabel();
         list = new ClipList(ClipListItemBillingBenefit);
         item = list.itemClipProvider;
         super();
         layout = new LayoutGroup();
         var _loc1_:HorizontalLayout = new HorizontalLayout();
         _loc1_.horizontalAlign = "center";
         _loc1_.verticalAlign = "middle";
         layout.layout = _loc1_;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout.x = list.graphics.x;
         layout.y = list.graphics.y;
         layout.width = list.graphics.width;
         layout.height = list.graphics.height;
         layout.addChild(list.list);
         container.addChild(layout);
         list.list.x = NaN;
         list.list.y = NaN;
         list.list.width = NaN;
         list.list.height = NaN;
         list.list.clipContent = false;
         list.list.verticalScrollPolicy = "off";
         list.list.horizontalScrollPolicy = "off";
         var _loc2_:VerticalLayout = new VerticalLayout();
         _loc2_.verticalAlign = "middle";
         _loc2_.useVirtualLayout = false;
         list.list.layout = _loc2_;
      }
      
      public function setDenseLayout() : void
      {
         (list.list.layout as VerticalLayout).gap = -4;
      }
   }
}
