package game.mechanics.clan_war.popup.leagues
{
   import game.assets.storage.AssetStorage;
   import game.mechanics.clan_war.model.ClanWarRaitingClanData;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanWarRatingClanItemRenderer extends ListItemRenderer
   {
       
      
      protected var clip:ClanWarRatingClanItemRendererClip;
      
      public function ClanWarRatingClanItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clip)
         {
            clip.dispose();
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:ClanWarRaitingClanData = data as ClanWarRaitingClanData;
         if(_loc1_)
         {
            clip.commitData(_loc1_,index);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanWarRatingClanItemRendererClip,"clan_war_raiting_clan_item_renderer");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
      }
   }
}
