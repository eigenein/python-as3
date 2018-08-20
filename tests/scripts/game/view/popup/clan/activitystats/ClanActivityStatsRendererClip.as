package game.view.popup.clan.activitystats
{
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiClipNestedContainer;
   import game.view.gui.components.ClipLabel;
   
   public class ClanActivityStatsRendererClip extends GuiClipNestedContainer
   {
       
      
      public var bg_player:ClipSprite;
      
      public var bg:ClipSprite;
      
      public var tf_player:ClipLabel;
      
      public var column_total:ClanActivityStatsColumnClip;
      
      public var column_day_:Vector.<ClanActivityStatsColumnClip>;
      
      public function ClanActivityStatsRendererClip()
      {
         bg_player = new ClipSprite();
         bg = new ClipSprite();
         tf_player = new ClipLabel();
         column_total = new ClanActivityStatsColumnClip();
         column_day_ = new Vector.<ClanActivityStatsColumnClip>();
         super();
      }
   }
}
