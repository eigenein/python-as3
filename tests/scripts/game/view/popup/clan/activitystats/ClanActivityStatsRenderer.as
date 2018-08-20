package game.view.popup.clan.activitystats
{
   import game.assets.storage.AssetStorage;
   import game.util.NumberUtils;
   import game.view.gui.components.controller.TouchHoverContoller;
   import game.view.gui.components.list.ListItemRenderer;
   
   public class ClanActivityStatsRenderer extends ListItemRenderer
   {
       
      
      private var clip:ClanActivityStatsRendererClip;
      
      private var hoverController:TouchHoverContoller;
      
      public function ClanActivityStatsRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
         hoverController.dispose();
      }
      
      override protected function commitData() : void
      {
         var _loc1_:int = 0;
         var _loc3_:int = 0;
         super.commitData();
         var _loc2_:ClanActivityStatsPopupVO = data as ClanActivityStatsPopupVO;
         if(clip && _loc2_)
         {
            clip.tf_player.text = _loc2_.nickname;
            clip.column_total.tf_points.text = NumberUtils.numberToString(_loc2_.value_total);
            clip.column_total.like_dungeonActivity.graphics.visible = false;
            clip.column_total.like_activity.graphics.visible = false;
            clip.bg_player.graphics.visible = _loc2_.isPlayer;
            _loc1_ = clip.column_day_.length;
            _loc3_ = 0;
            while(_loc3_ < _loc1_)
            {
               clip.column_day_[_loc3_].like_dungeonActivity.graphics.visible = _loc2_.likeFlags[_loc3_] && _loc2_.isDungeon;
               clip.column_day_[_loc3_].like_activity.graphics.visible = _loc2_.likeFlags[_loc3_] && !_loc2_.isDungeon;
               if(_loc2_.likeFlags[_loc3_])
               {
                  clip.column_day_[_loc3_].tf_points.text = "^{249 247 243}^" + NumberUtils.numberToString(_loc2_.value_byDay(_loc3_));
               }
               else
               {
                  clip.column_day_[_loc3_].tf_points.text = "^{252 229 183}^" + NumberUtils.numberToString(_loc2_.value_byDay(_loc3_));
               }
               _loc3_++;
            }
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.popup_theme.create(ClanActivityStatsRendererClip,"clan_activity_stats_renderer");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.graphics.useHandCursor = true;
         clip.bg.graphics.alpha = 0;
         clip.bg_player.graphics.visible = false;
         hoverController = new TouchHoverContoller(clip.container);
         hoverController.signal_hoverChanger.add(handler_hover);
         clip.container.useHandCursor = false;
      }
      
      private function handler_hover() : void
      {
         if(hoverController.hover)
         {
            clip.bg.graphics.alpha = 0.2;
         }
         else
         {
            clip.bg.graphics.alpha = 0;
         }
      }
   }
}
