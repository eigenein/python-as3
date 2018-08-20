package game.view.popup.rating
{
   import game.command.rpc.rating.CommandRatingTopGetResultUserEntry;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLabel;
   
   public class RatingPopupListItemRendererPlayerClip extends RatingPopupListItemRendererClip
   {
       
      
      public var button_no_clan:ClipButtonLabeled;
      
      public var tf_no_clan:ClipLabel;
      
      public function RatingPopupListItemRendererPlayerClip()
      {
         super();
      }
      
      public function setupBlockVisibility(param1:Boolean, param2:Boolean) : void
      {
         button_no_clan.graphics.visible = param2;
         button_no_clan.graphics.touchable = param2;
         tf_no_clan.visible = param2;
         tf_label_place.visible = param1;
         tf_label_rating_value.visible = param1;
         tf_level.visible = param1;
         tf_name.visible = param1;
         tf_no_level.visible = param1;
         tf_rating_value.visible = param1;
      }
      
      override protected function setupUser(param1:CommandRatingTopGetResultUserEntry) : void
      {
         super.setupUser(param1);
         clan_icon.graphics.visible = false;
      }
   }
}
