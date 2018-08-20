package game.view.popup.fightresult
{
   import com.progrestar.framework.ares.core.Node;
   import engine.core.clipgui.GuiClipContainer;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class RewardDialogHeroPanelBase extends GuiClipNestedContainer
   {
       
      
      private var bg:GuiClipNestedContainer;
      
      public var tf_hero_name:ClipLabel;
      
      public var heroBrownBG_inst0:GuiClipContainer;
      
      public var hero_portrait:GuiClipContainer;
      
      public function RewardDialogHeroPanelBase()
      {
         tf_hero_name = new ClipLabel();
         super();
      }
      
      override public function setNode(param1:Node) : void
      {
         super.setNode(param1);
      }
   }
}
