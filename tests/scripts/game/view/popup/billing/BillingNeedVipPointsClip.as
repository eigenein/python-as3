package game.view.popup.billing
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.ClipLayout;
   
   public class BillingNeedVipPointsClip extends GuiClipNestedContainer
   {
       
      
      private var need_more:String;
      
      private var max_level:String;
      
      public var tf_need_label:ClipLabel;
      
      public var tf_need_value:ClipLabel;
      
      public var tf_for_label:ClipLabel;
      
      public var next_vip_level:BillingVipLevelBlock;
      
      public var tf_vip_points_label:ClipLabel;
      
      public var vip_word:ClipSprite;
      
      public var icon_gem:ClipSprite;
      
      public var layout_needs:ClipLayout;
      
      private var _showGemIcon:Boolean;
      
      private var _isMaxLevel:Boolean;
      
      public function BillingNeedVipPointsClip()
      {
         tf_need_label = new ClipLabel(true);
         tf_need_value = new ClipLabel(true);
         tf_for_label = new ClipLabel(true);
         next_vip_level = new BillingVipLevelBlock();
         tf_vip_points_label = new ClipLabel(true);
         vip_word = new ClipSprite();
         icon_gem = new ClipSprite();
         layout_needs = ClipLayout.horizontalMiddleCentered(4,tf_need_label,icon_gem,tf_need_value,vip_word,tf_vip_points_label,tf_for_label,next_vip_level);
         super();
         need_more = Translate.translate("UI_DIALOG_BILLING_NEED");
         max_level = Translate.translate("UI_DIALOG_BILLING_MAX_LEVEL");
         tf_for_label.text = Translate.translate("UI_DIALOG_BILLING_FOR");
         tf_vip_points_label.text = Translate.translate("UI_DIALOG_BILLING_VIP_POINTS");
      }
      
      public function get showGemIcon() : Boolean
      {
         return _showGemIcon;
      }
      
      public function set showGemIcon(param1:Boolean) : void
      {
         _showGemIcon = param1;
         isMaxLevel = _isMaxLevel;
      }
      
      private function set isMaxLevel(param1:Boolean) : void
      {
         this._isMaxLevel = param1;
         var _loc2_:* = !param1;
         next_vip_level.graphics.visible = _loc2_;
         _loc2_ = _loc2_;
         tf_for_label.graphics.visible = _loc2_;
         tf_need_value.graphics.visible = _loc2_;
         _loc2_ = !_showGemIcon && !param1;
         tf_vip_points_label.visible = _loc2_;
         vip_word.graphics.visible = _loc2_;
         icon_gem.graphics.visible = _showGemIcon && !param1;
      }
      
      public function setProgress(param1:int, param2:int) : void
      {
         tf_need_label.text = need_more;
         tf_need_value.text = String(param1);
         next_vip_level.setVip(param2);
         isMaxLevel = false;
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
      
      public function setMax() : void
      {
         var _loc1_:* = true;
         next_vip_level.graphics.visible = _loc1_;
         _loc1_ = _loc1_;
         tf_for_label.graphics.visible = _loc1_;
         _loc1_ = _loc1_;
         tf_need_value.graphics.visible = _loc1_;
         _loc1_ = _loc1_;
         tf_vip_points_label.visible = _loc1_;
         vip_word.graphics.visible = _loc1_;
         tf_need_label.text = max_level;
         isMaxLevel = true;
      }
   }
}
