package game.view.popup.fightresult.pve.defeatpopuprenderers
{
   import com.progrestar.common.lang.Translate;
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class ImprovementRenderer extends GuiClipNestedContainer
   {
       
      
      public var button_stats:ClipButtonLabeled;
      
      public var label_desc:ClipLabel;
      
      public var bg:ClipSprite;
      
      public var line_bottom:ClipSprite;
      
      public var line_top:ClipSprite;
      
      public var pic:ClipSprite;
      
      public function ImprovementRenderer()
      {
         button_stats = new ClipButtonLabeled();
         label_desc = new ClipLabel();
         bg = new ClipSprite();
         line_bottom = new ClipSprite();
         line_top = new ClipSprite();
         pic = new ClipSprite();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         button_stats.label = Translate.translate("UI_DIALOG_DEFEAT_GO");
      }
   }
}
