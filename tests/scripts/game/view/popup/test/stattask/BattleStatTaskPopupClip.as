package game.view.popup.test.stattask
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.ClipSpriteUntouchable;
   import game.view.PopupClipBase;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipInput;
   import game.view.gui.components.ClipLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class BattleStatTaskPopupClip extends PopupClipBase
   {
       
      
      public const input:ClipInput = new ClipInput();
      
      public const tf_output:SpecialClipLabel = new SpecialClipLabel();
      
      public const scrollbar_output:GameScrollBar = new GameScrollBar();
      
      public const gradient_top:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const gradient_bottom:ClipSpriteUntouchable = new ClipSpriteUntouchable();
      
      public const layout_output:GameScrollContainer = new GameScrollContainer(scrollbar_output,gradient_top.graphics,gradient_bottom.graphics);
      
      public const tf_result:ClipLabel = new ClipLabel();
      
      public const button_result:ClipButtonLabeled = new ClipButtonLabeled();
      
      public const button_start:ClipButtonLabeled = new ClipButtonLabeled();
      
      public function BattleStatTaskPopupClip()
      {
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
         layout_output.addChild(tf_output);
      }
   }
}
