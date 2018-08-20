package game.view.popup.clan.activitystats
{
   import engine.core.clipgui.GuiClipImage;
   import engine.core.clipgui.GuiClipNestedContainer;
   import engine.core.clipgui.GuiClipScale3Image;
   import game.view.gui.components.ClipLabel;
   
   public class ClanActivityStatsRendererGiftClip extends GuiClipNestedContainer
   {
       
      
      public var tf_amount:ClipLabel;
      
      public var icon:GuiClipImage;
      
      public var bg:GuiClipScale3Image;
      
      public function ClanActivityStatsRendererGiftClip()
      {
         tf_amount = new ClipLabel();
         icon = new GuiClipImage();
         bg = new GuiClipScale3Image(12,1);
         super();
      }
   }
}
