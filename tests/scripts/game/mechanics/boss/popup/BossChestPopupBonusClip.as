package game.mechanics.boss.popup
{
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   
   public class BossChestPopupBonusClip extends GuiClipNestedContainer
   {
       
      
      public var tf_text:ClipLabel;
      
      public var ArrowPurpleMid_78_76_1_inst0:GuiClipScale3Image;
      
      public function BossChestPopupBonusClip()
      {
         tf_text = new ClipLabel();
         ArrowPurpleMid_78_76_1_inst0 = new GuiClipScale3Image(78,1);
         super();
      }
   }
}
