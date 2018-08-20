package game.mechanics.clan_war.popup.leagues
{
   public class ClanWarLastWeekRatingClanItemRenderer extends ClanWarRatingClanItemRenderer
   {
       
      
      public function ClanWarLastWeekRatingClanItemRenderer()
      {
         super();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         clip.up_icon.graphics.visible = false;
      }
   }
}
