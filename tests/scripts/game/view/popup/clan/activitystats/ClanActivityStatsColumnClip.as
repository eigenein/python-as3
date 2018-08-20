package game.view.popup.clan.activitystats
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.SpecialClipLabel;
   
   public class ClanActivityStatsColumnClip extends GuiClipNestedContainer
   {
       
      
      public var like_activity:ClipSprite;
      
      public var like_dungeonActivity:ClipSprite;
      
      public var tf_points:SpecialClipLabel;
      
      public function ClanActivityStatsColumnClip()
      {
         like_activity = new ClipSprite();
         like_dungeonActivity = new ClipSprite();
         tf_points = new SpecialClipLabel();
         super();
      }
   }
}
