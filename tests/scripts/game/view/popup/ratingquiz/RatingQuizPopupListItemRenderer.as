package game.view.popup.ratingquiz
{
   import game.assets.storage.AssetStorage;
   import game.command.rpc.rating.CommandRatingTopGetResultClanDungeonEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultClanEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultNYTreeDecorateActionsEntry;
   import game.command.rpc.rating.CommandRatingTopGetResultUserEntry;
   import game.view.gui.components.list.ListItemRenderer;
   import game.view.popup.rating.RatingPopupListItemRendererClip;
   
   public class RatingQuizPopupListItemRenderer extends ListItemRenderer
   {
       
      
      protected var clipUser:RatingPopupListItemRendererClip;
      
      protected var clipClan:RatingPopupListItemRendererClip;
      
      public function RatingQuizPopupListItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         if(clipUser)
         {
            clipUser.dispose();
         }
         if(clipClan)
         {
            clipClan.dispose();
         }
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         super.commitData();
         var _loc1_:CommandRatingTopGetResultEntry = data as CommandRatingTopGetResultEntry;
         if(_loc1_ is CommandRatingTopGetResultUserEntry)
         {
            clipUser.commitData(_loc1_);
            addChild(clipUser.graphics);
            removeChild(clipClan.graphics);
         }
         else if(_loc1_ is CommandRatingTopGetResultClanEntry || _loc1_ is CommandRatingTopGetResultClanDungeonEntry || _loc1_ is CommandRatingTopGetResultNYTreeDecorateActionsEntry)
         {
            clipClan.commitData(_loc1_);
            removeChild(clipUser.graphics);
            addChild(clipClan.graphics);
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clipClan = AssetStorage.rsx.popup_theme.create(RatingPopupListItemRendererClip,"rating_item_clan_renderer");
         clipUser = AssetStorage.rsx.popup_theme.create(RatingPopupListItemRendererClip,"rating_item_renderer");
         width = clipUser.bg.graphics.width;
         height = clipUser.bg.graphics.height;
      }
   }
}
