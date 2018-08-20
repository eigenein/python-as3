package game.mechanics.titan_arena.popup.raid
{
   import com.progrestar.common.lang.Translate;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.model.TitanArenaRaidBattleItem;
   import game.model.user.inventory.InventoryItem;
   import game.view.gui.components.list.ListItemRenderer;
   import org.osflash.signals.Signal;
   import ru.crazybit.socexp.view.core.text.ColorUtils;
   
   public class TitanArenaRaidPopupBattleItemRenderer extends ListItemRenderer
   {
       
      
      private var __data:TitanArenaRaidBattleItem;
      
      private var clip:TitanArenaRaidPopupBattleItemRendererClip;
      
      public const signal_info:Signal = new Signal(TitanArenaRaidBattleItem);
      
      public function TitanArenaRaidPopupBattleItemRenderer()
      {
         super();
      }
      
      override public function dispose() : void
      {
         super.dispose();
      }
      
      override protected function commitData() : void
      {
         var _loc1_:* = null;
         var _loc2_:* = null;
         super.commitData();
         __data = data as TitanArenaRaidBattleItem;
         if(__data)
         {
            clip.portrait.setData(__data.enemy);
            clip.clan_icon.setData(__data.enemy.clanInfo);
            clip.tf_points_attack.text = getPointsString(__data.enemy.points_attack,__data.enemy.points_attackMax);
            clip.tf_points_defence.text = getPointsString(__data.enemy.points_defense,__data.enemy.points_defenseMax);
            clip.tf_name.text = __data.enemy.nickname;
            _loc1_ = ColorUtils.hexToRGBFormat(10062443) + Translate.translateArgs("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_SERVER",__data.enemy.serverId);
            if(__data.enemy.clanInfo)
            {
               clip.tf_clan.text = __data.enemy.clanInfo.title + "  " + _loc1_;
            }
            else
            {
               clip.tf_clan.text = _loc1_;
            }
            clip.tf_power.text = Translate.translateArgs("UI_TITAN_ARENA_PLAYER_PANEL_TF_LABEL_POWER",__data.enemy.power);
            _loc2_ = __data.rewardInventoryItem;
            clip.icon_reward.setData(__data.rewardInventoryItem);
            clip.icon_reward.graphics.visible = _loc2_ != null;
            clip.layout_battleResult.graphics.visible = !__data.invalidBattle;
            clip.tf_invalidBattle.graphics.visible = __data.invalidBattle;
         }
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.createClip("dialog_titan_arena",TitanArenaRaidPopupBattleItemRendererClip,"dialog_titan_arena_raid_item");
         addChild(clip.graphics);
         width = clip.bg.graphics.width;
         height = clip.bg.graphics.height;
         clip.tf_label_attack.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_ATTACK");
         clip.tf_label_defence.text = Translate.translate("UI_DIALOG_TITAN_ARENA_RAID_DEFENCE");
         clip.tf_invalidBattle.text = Translate.translate("UI_POPUP_ERROR_BATTLE_VERSION_HIGH");
         clip.button_info.signal_click.add(handler_info);
      }
      
      protected function getPointsString(param1:int, param2:int) : String
      {
         if(param1 == param2)
         {
            return ColorUtils.hexToRGBFormat(15007564) + String(param1) + "/" + String(param2) + ColorUtils.hexToRGBFormat(16777215);
         }
         return String(param1) + "/" + String(param2);
      }
      
      private function handler_info() : void
      {
         if(__data)
         {
            signal_info.dispatch(__data);
         }
      }
   }
}
