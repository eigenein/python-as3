package game.view.popup.arena
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   import game.view.popup.shop.ShopCostPanel;
   
   public class ArenaCooldownsClip extends GuiClipNestedContainer
   {
       
      
      public var tf_timer:ClipLabel;
      
      public var tf_timer_caption:ClipLabel;
      
      public var btn_skip_cooldown:ClipButtonLabeled;
      
      public var icon_timer_inst0:ClipSprite;
      
      public var skip_cost:ShopCostPanel;
      
      public function ArenaCooldownsClip()
      {
         tf_timer = new ClipLabel(true);
         tf_timer_caption = new ClipLabel();
         btn_skip_cooldown = new ClipButtonLabeled();
         icon_timer_inst0 = new ClipSprite();
         skip_cost = new ShopCostPanel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         tf_timer_caption.text = Translate.translate("UI_DIALOG_ARENA_TIMER_CAPTION");
         btn_skip_cooldown.label = Translate.translate("UI_DIALOG_ARENA_SKIP_CD");
      }
   }
}
