package game.view.popup.theme
{
   import engine.core.assets.loading.RsxAssetLoader;
   import engine.core.clipgui.GuiClipNestedContainer;
   import feathers.textures.Scale3Textures;
   import feathers.textures.Scale9Textures;
   import flash.geom.Rectangle;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.battle.gui.BattleGUIProgressbarBlock;
   import game.mechanics.grand.popup.GrandBattleResultFinalPopupClip;
   import game.mechanics.grand.popup.GrandBattleResultHeaderClip;
   import game.mechanics.grand.popup.GrandBattleResultSinglePopupClip;
   import game.mechanics.grand.popup.GrandPopupClip;
   import game.mechanics.grand.popup.GrandSelectEnemyPopupClip;
   import game.mechanics.grand.popup.TooltipGrandEnemyTeamClip;
   import game.mechanics.grand.popup.log.GrandLogInfoClip;
   import game.mechanics.grand.popup.log.GrandLogListItemRendererClip;
   import game.mediator.gui.popup.chat.userinfo.ChatUserInfoPopUpClip;
   import game.mediator.gui.popup.hero.HeroTitanGiftLevelDropPopUpClip;
   import game.mediator.gui.popup.hero.skin.SkinInfoPopUpClip;
   import game.mediator.gui.popup.hero.skin.SkinLevelUpPopUpClip;
   import game.mediator.gui.popup.titan.TitanDescriptionPopupClip;
   import game.mediator.gui.popup.titan.TitanPopupClip;
   import game.mediator.gui.popup.titan.minilist.TitanPopupMiniTitanListItemClip;
   import game.view.gui.components.ClipButton;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipProgressBar;
   import game.view.gui.components.InventoryItemIcon;
   import game.view.popup.activity.ChainEventQuestsViewClip;
   import game.view.popup.activity.ChainQuestsListRendererClip;
   import game.view.popup.activity.DailyBonusViewClip;
   import game.view.popup.activity.EventListItemRendererClip;
   import game.view.popup.activity.SkinShopViewClip;
   import game.view.popup.activity.SpecialQuestEventPopupClip;
   import game.view.popup.activity.SpecialQuestListItemRendererClip;
   import game.view.popup.alchemy.AlchemyPopupClip;
   import game.view.popup.arena.ArenaCooldownAlertPopupClip;
   import game.view.popup.arena.ArenaPopupClip;
   import game.view.popup.arena.log.ArenaLogEntryPopupClip;
   import game.view.popup.arena.log.ArenaLogItemRendererClip;
   import game.view.popup.arena.log.ArenaLogPopupClip;
   import game.view.popup.arena.rules.ArenaRulesPlaceRewardClip;
   import game.view.popup.arena.rules.ArenaRulesPopupClip;
   import game.view.popup.billing.BillingConfirmPopupClip;
   import game.view.popup.billing.BillingPopupClip;
   import game.view.popup.billing.VipBenefitPopupClip;
   import game.view.popup.blasklist.BlackListPopUpClip;
   import game.view.popup.chestrewardheroeslist.ChestRewardHeroesListPopUpClip;
   import game.view.popup.chestrewardheroeslist.ChestRewardHeroesListRendererClip;
   import game.view.popup.clan.ClanItemForActivityPopupClip;
   import game.view.popup.clan.editicon.ClanEditIconPopupClip;
   import game.view.popup.common.PopupSideTab;
   import game.view.popup.common.resourcepanel.PopupResourcePanelItem;
   import game.view.popup.dailybonus.DailyBonusPopupClip;
   import game.view.popup.dailybonus.DailyBonusPopupTileClip;
   import game.view.popup.dailybonus.DailyBonusPopupVipNeededClip;
   import game.view.popup.dailybonus.DailyBonusRewardPopupClip;
   import game.view.popup.fightresult.pve.MissionDefeatPopupClip;
   import game.view.popup.fightresult.pve.MissionRewardDialogClip;
   import game.view.popup.fightresult.pve.MissionRewardDialogHeroPanel;
   import game.view.popup.fightresult.pvp.ArenaVictoryPopupClip;
   import game.view.popup.fightresult.pvp.ArenaVictoryPopupHeroPanelClip;
   import game.view.popup.friends.FriendsDailyGiftGMRPopupClip;
   import game.view.popup.friends.FriendsDailyGiftPopupClip;
   import game.view.popup.hero.HeroArtifactListPopupItemClip;
   import game.view.popup.hero.HeroElementListPopupItemClip;
   import game.view.popup.hero.HeroListDialogClip;
   import game.view.popup.hero.HeroListDialogItemClip;
   import game.view.popup.hero.HeroListForgeDialogClip;
   import game.view.popup.hero.HeroPopupClip;
   import game.view.popup.hero.HeroRuneListPopupItemClip;
   import game.view.popup.hero.consumable.HeroListDialogConsumableItemClip;
   import game.view.popup.hero.consumable.HeroUseConsumableDialogClip;
   import game.view.popup.hero.minilist.HeroPopupMiniHeroListItemClip;
   import game.view.popup.hero.rune.HeroElementPopupClip;
   import game.view.popup.hero.rune.HeroRunePopupClip;
   import game.view.popup.hero.skins.SkinListItemClip;
   import game.view.popup.hero.slot.HeroSlotPopupClip;
   import game.view.popup.hero.upgrade.HeroColorUpPopupClip;
   import game.view.popup.hero.upgrade.HeroStarUpPopupClip;
   import game.view.popup.herodescription.HeroDescriptionPopUpClip;
   import game.view.popup.inventory.PlayerInventoryPopupClip;
   import game.view.popup.inventory.SellItemPopupClip;
   import game.view.popup.inventory.UseStaminaItemPopupClip;
   import game.view.popup.mail.PlayerMailEntryPopupClip;
   import game.view.popup.mail.PlayerMailMultifarmPopupClip;
   import game.view.popup.mail.PlayerMailPopupClip;
   import game.view.popup.mail.PlayerMailRendererClip;
   import game.view.popup.ny.gifts.NYGiftsPopupTabRendererClip;
   import game.view.popup.player.AvatarPickRendererClip;
   import game.view.popup.player.AvatarSelectPopupClip;
   import game.view.popup.player.LevelUpPopupClip;
   import game.view.popup.player.PlayerNicknameChangePopupClip;
   import game.view.popup.player.PlayerProfilePopupClip;
   import game.view.popup.quest.QuestListItemClip;
   import game.view.popup.quest.QuestListPopupClip;
   import game.view.popup.reward.RewardHeroPopupClip;
   import game.view.popup.reward.multi.MultiRewardGroupedPopupClip;
   import game.view.popup.reward.multi.MultiRewardRendererClip;
   import game.view.popup.settings.SettingsPopupClip;
   import game.view.popup.shop.ShopRsxPopupClip;
   import game.view.popup.shop.ShopTileClip;
   import game.view.popup.shop.soul.SoulShopSellFragmentsPopupClip;
   import game.view.popup.shop.special.SpecialShopMiniHeroListItemClip;
   import game.view.popup.statistics.BattleStatisticsPopupClip;
   import game.view.popup.team.GrandTeamGatherAttackPopupGuiClip;
   import game.view.popup.team.GrandTeamGatherPopupGuiClip;
   import game.view.popup.team.MultiTeamGatherTeamLabel;
   import game.view.popup.team.TeamGatherPopupGuiClip;
   import game.view.popup.team.TowerTeamGatherClip;
   import game.view.popup.titan.TitanArtifactListPopupItemClip;
   import game.view.popup.tower.TowerBattleFloorPopupClip;
   import game.view.popup.tower.TowerBuffFloorPopupClip;
   import game.view.popup.tower.TowerBuffSelectHeroItemClip;
   import game.view.popup.tower.TowerBuffSelectHeroPopupClip;
   import game.view.popup.tower.TowerChestFloorPopupClip;
   import game.view.popup.tower.TowerTeamGatherPopupHeroRendererDeadLabelClip;
   import starling.display.DisplayObject;
   import starling.textures.Texture;
   
   public class RsxPopupTheme extends RsxGuiAsset
   {
      
      public static const IDENT:String = "dialog_basic";
       
      
      public var missingScale3:Scale3Textures;
      
      public var missingScale9:Scale9Textures;
      
      private var _get_buttonTextureDefault_rect:Rectangle;
      
      public function RsxPopupTheme(param1:*)
      {
         _get_buttonTextureDefault_rect = new Rectangle(23,23,2,2);
         super(param1);
      }
      
      override public function complete() : void
      {
         super.complete();
         RsxAssetLoader.commonAsset.value = data;
         missingScale3 = new Scale3Textures(missing_texture,0,1);
         missingScale9 = new Scale9Textures(missing_texture,new Rectangle(2,2,2,2));
      }
      
      public function get filter_disabled() : ColorMatrixFilterDisabled
      {
         var _loc1_:ColorMatrixFilterDisabled = new ColorMatrixFilterDisabled();
         _loc1_.color(3616549,1);
         return _loc1_;
      }
      
      public function get missing_texture() : Texture
      {
         return getTexture("missing_texture");
      }
      
      public function setDisabledFilter(param1:DisplayObject, param2:Boolean) : void
      {
         if(param2)
         {
            if(!param1.filter)
            {
               param1.filter = AssetStorage.rsx.popup_theme.filter_disabled;
            }
         }
         else if(param1.filter is ColorMatrixFilterDisabled)
         {
            param1.filter.dispose();
            param1.filter = null;
         }
      }
      
      public function get_buttonTextureDefault() : Scale9Textures
      {
         return getScale9Textures("square_button_23_23_2_2",_get_buttonTextureDefault_rect);
      }
      
      public function get_buttonTextureBlue() : Scale9Textures
      {
         return getScale9Textures("square_buttonBlue_23_23_2_2",_get_buttonTextureDefault_rect);
      }
      
      public function button_label18() : ClipButtonLabeled
      {
         var _loc1_:ClipButtonLabeled = new ClipButtonLabeled();
         _factory.create(_loc1_,data.getClipByName("green_labeled_button_130"));
         return _loc1_;
      }
      
      public function button_settings() : ClipButton
      {
         var _loc1_:ClipButton = new ClipButton();
         _factory.create(_loc1_,data.getClipByName("squareButton_settings"));
         return _loc1_;
      }
      
      public function button_fullscreen_on() : ClipButton
      {
         var _loc1_:ClipButton = new ClipButton();
         _factory.create(_loc1_,data.getClipByName("squareButton_fullScreenOn"));
         return _loc1_;
      }
      
      public function button_fullscreen_off() : ClipButton
      {
         var _loc1_:ClipButton = new ClipButton();
         _factory.create(_loc1_,data.getClipByName("squareButton_fullScreenOff"));
         return _loc1_;
      }
      
      public function create_dialog_hero_list() : HeroListDialogClip
      {
         var _loc1_:HeroListDialogClip = new HeroListDialogClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list"));
         return _loc1_;
      }
      
      public function create_dialog_hero_list_forge() : HeroListForgeDialogClip
      {
         var _loc1_:HeroListForgeDialogClip = new HeroListForgeDialogClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_forge"));
         return _loc1_;
      }
      
      public function create_dialog_hero_artifact_list() : HeroListDialogClip
      {
         var _loc1_:HeroListDialogClip = new HeroListDialogClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_artifact_list"));
         return _loc1_;
      }
      
      public function create_dialog_hero_list_consumable() : HeroUseConsumableDialogClip
      {
         var _loc1_:HeroUseConsumableDialogClip = new HeroUseConsumableDialogClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_consumable"));
         return _loc1_;
      }
      
      public function create_dialog_hero_list_item() : HeroListDialogItemClip
      {
         var _loc1_:HeroListDialogItemClip = new HeroListDialogItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_hero_panel"));
         return _loc1_;
      }
      
      public function create_dialog_titan_list_item() : HeroListDialogItemClip
      {
         var _loc1_:HeroListDialogItemClip = new HeroListDialogItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_titan_list_titan_panel"));
         return _loc1_;
      }
      
      public function create_dialog_hero_list_consumable_item() : HeroListDialogConsumableItemClip
      {
         var _loc1_:HeroListDialogConsumableItemClip = new HeroListDialogConsumableItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_use_consumable_item"));
         return _loc1_;
      }
      
      public function create_dialog_hero_rune_list_item() : HeroRuneListPopupItemClip
      {
         var _loc1_:HeroRuneListPopupItemClip = new HeroRuneListPopupItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_rune_panel"));
         return _loc1_;
      }
      
      public function create_dialog_hero_artifact_list_item() : HeroArtifactListPopupItemClip
      {
         var _loc1_:HeroArtifactListPopupItemClip = new HeroArtifactListPopupItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_artifact_panel"));
         return _loc1_;
      }
      
      public function create_dialog_titan_artifact_list_item() : TitanArtifactListPopupItemClip
      {
         var _loc1_:TitanArtifactListPopupItemClip = new TitanArtifactListPopupItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_artifact_panel"));
         return _loc1_;
      }
      
      public function create_dialog_hero_element_list_item() : HeroElementListPopupItemClip
      {
         var _loc1_:HeroElementListPopupItemClip = new HeroElementListPopupItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_list_element_panel"));
         return _loc1_;
      }
      
      public function create_dialog_quest_list() : QuestListPopupClip
      {
         var _loc1_:QuestListPopupClip = new QuestListPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_quest_list"));
         return _loc1_;
      }
      
      public function create_dialog_quest_list_item() : QuestListItemClip
      {
         var _loc1_:QuestListItemClip = new QuestListItemClip();
         _factory.create(_loc1_,data.getClipByName("dialog_quest_list_panel"));
         return _loc1_;
      }
      
      public function create_special_quest_list_item() : SpecialQuestListItemRendererClip
      {
         var _loc1_:SpecialQuestListItemRendererClip = new SpecialQuestListItemRendererClip();
         _factory.create(_loc1_,data.getClipByName("special_quest_list_panel"));
         return _loc1_;
      }
      
      public function create_hero_popup_mini_item() : HeroPopupMiniHeroListItemClip
      {
         var _loc1_:HeroPopupMiniHeroListItemClip = new HeroPopupMiniHeroListItemClip();
         _factory.create(_loc1_,data.getClipByName("hero_dialog_mini_hero"));
         return _loc1_;
      }
      
      public function create_special_shop_hero_mini_item() : SpecialShopMiniHeroListItemClip
      {
         var _loc1_:SpecialShopMiniHeroListItemClip = new SpecialShopMiniHeroListItemClip();
         _factory.create(_loc1_,data.getClipByName("special_shop_mini_hero"));
         return _loc1_;
      }
      
      public function create_titan_popup_mini_item() : TitanPopupMiniTitanListItemClip
      {
         var _loc1_:TitanPopupMiniTitanListItemClip = new TitanPopupMiniTitanListItemClip();
         _factory.create(_loc1_,data.getClipByName("titan_dialog_mini_titan"));
         return _loc1_;
      }
      
      public function create_dialog_hero() : HeroPopupClip
      {
         var _loc1_:HeroPopupClip = new HeroPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero"));
         return _loc1_;
      }
      
      public function create_dialog_titan() : TitanPopupClip
      {
         var _loc1_:TitanPopupClip = new TitanPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_titan_new"));
         return _loc1_;
      }
      
      public function create_dialog_hero_slot() : HeroSlotPopupClip
      {
         var _loc1_:HeroSlotPopupClip = new HeroSlotPopupClip();
         _factory.create(_loc1_,AssetStorage.rsx.popup_theme.data.getClipByName("dialog_hero_slot_craft"));
         return _loc1_;
      }
      
      public function create_dialog_shop() : ShopRsxPopupClip
      {
         var _loc1_:ShopRsxPopupClip = new ShopRsxPopupClip();
         _factory.create(_loc1_,AssetStorage.rsx.popup_theme.data.getClipByName("dialog_shop"));
         return _loc1_;
      }
      
      public function create_renderer_shop() : ShopTileClip
      {
         var _loc1_:ShopTileClip = new ShopTileClip();
         _factory.create(_loc1_,AssetStorage.rsx.popup_theme.data.getClipByName("shop_tile"));
         return _loc1_;
      }
      
      public function create_dialog_player_inventory() : PlayerInventoryPopupClip
      {
         var _loc1_:PlayerInventoryPopupClip = new PlayerInventoryPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_inventory"));
         return _loc1_;
      }
      
      public function create_dialog_player_inventory_sell_item() : SellItemPopupClip
      {
         var _loc1_:SellItemPopupClip = new SellItemPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_inventory_item_sell"));
         return _loc1_;
      }
      
      public function create_dialog_player_inventory_use_stamina() : UseStaminaItemPopupClip
      {
         var _loc1_:UseStaminaItemPopupClip = new UseStaminaItemPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_inventory_item_use"));
         return _loc1_;
      }
      
      public function create_side_dialog_tab() : PopupSideTab
      {
         var _loc1_:PopupSideTab = new PopupSideTab();
         _factory.create(_loc1_,data.getClipByName("dialog_side_tab"));
         return _loc1_;
      }
      
      public function create_side_dialog_tab_hero() : PopupSideTab
      {
         var _loc1_:PopupSideTab = new PopupSideTab();
         _factory.create(_loc1_,data.getClipByName("dialog_side_tab_hero"));
         return _loc1_;
      }
      
      public function create_side_dialog_tab_inventory() : PopupSideTab
      {
         var _loc1_:PopupSideTab = new PopupSideTab();
         _factory.create(_loc1_,data.getClipByName("dialog_side_tab_inventory"));
         return _loc1_;
      }
      
      public function create_renderer_resource_panel() : PopupResourcePanelItem
      {
         var _loc1_:PopupResourcePanelItem = new PopupResourcePanelItem();
         _factory.create(_loc1_,data.getClipByName("resource_mini_panel"));
         return _loc1_;
      }
      
      public function create_dialog_alchemy() : AlchemyPopupClip
      {
         var _loc1_:AlchemyPopupClip = new AlchemyPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_alchemy"));
         return _loc1_;
      }
      
      public function create_dialog_billing() : BillingPopupClip
      {
         var _loc1_:BillingPopupClip = new BillingPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_billing"));
         return _loc1_;
      }
      
      public function create_popup_billing_confirm() : BillingConfirmPopupClip
      {
         var _loc1_:BillingConfirmPopupClip = new BillingConfirmPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_billing_confirm"));
         return _loc1_;
      }
      
      public function create_dialog_vip_benefit() : VipBenefitPopupClip
      {
         var _loc1_:VipBenefitPopupClip = new VipBenefitPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_vip_benefit"));
         return _loc1_;
      }
      
      public function create_dialog_arena() : ArenaPopupClip
      {
         var _loc1_:ArenaPopupClip = new ArenaPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_arena"));
         return _loc1_;
      }
      
      public function create_dialog_arena_rules() : ArenaRulesPopupClip
      {
         var _loc1_:ArenaRulesPopupClip = new ArenaRulesPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_arena_rules"));
         return _loc1_;
      }
      
      public function create_renderer_arena_rules() : ArenaRulesPlaceRewardClip
      {
         var _loc1_:ArenaRulesPlaceRewardClip = new ArenaRulesPlaceRewardClip();
         _factory.create(_loc1_,data.getClipByName("arena_rules_renderer"));
         return _loc1_;
      }
      
      public function create_grand_arena_rules() : ArenaRulesPlaceRewardClip
      {
         var _loc1_:ArenaRulesPlaceRewardClip = new ArenaRulesPlaceRewardClip();
         _factory.create(_loc1_,data.getClipByName("grand_rules_renderer"));
         return _loc1_;
      }
      
      public function create_dialog_grand_arena() : GrandPopupClip
      {
         return create(GrandPopupClip,"dialog_grand_arena");
      }
      
      public function create_tooltip_grand_enemy_team() : TooltipGrandEnemyTeamClip
      {
         return create(TooltipGrandEnemyTeamClip,"tooltip_grand_enemy_team");
      }
      
      public function create_dialog_grand_select_enemy() : GrandSelectEnemyPopupClip
      {
         return create(GrandSelectEnemyPopupClip,"dialog_grand_select_enemy");
      }
      
      public function create_dialog_grand_log_info() : GrandLogInfoClip
      {
         return create(GrandLogInfoClip,"dialog_grand_log_info");
      }
      
      public function create_dialog_grand_log_info_2_elements() : GrandLogInfoClip
      {
         return create(GrandLogInfoClip,"dialog_grand_log_info_2_elements");
      }
      
      public function create_dialog_arena_log() : ArenaLogPopupClip
      {
         var _loc1_:ArenaLogPopupClip = new ArenaLogPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_arena_battle_logs"));
         return _loc1_;
      }
      
      public function create_renderer_arena_log() : ArenaLogItemRendererClip
      {
         var _loc1_:ArenaLogItemRendererClip = new ArenaLogItemRendererClip();
         _factory.create(_loc1_,data.getClipByName("dialog_arena_log_item"));
         return _loc1_;
      }
      
      public function create_dialog_arena_cd_alert() : ArenaCooldownAlertPopupClip
      {
         var _loc1_:ArenaCooldownAlertPopupClip = new ArenaCooldownAlertPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_arena_cd_alert"));
         return _loc1_;
      }
      
      public function create_dialog_arena_log_info() : ArenaLogEntryPopupClip
      {
         var _loc1_:ArenaLogEntryPopupClip = new ArenaLogEntryPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_arena_log_info"));
         return _loc1_;
      }
      
      public function create_popup_battle_statistics() : BattleStatisticsPopupClip
      {
         var _loc1_:BattleStatisticsPopupClip = new BattleStatisticsPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_battle_statistics"));
         return _loc1_;
      }
      
      public function create_dialog_friend_gifts() : FriendsDailyGiftPopupClip
      {
         var _loc1_:FriendsDailyGiftPopupClip = new FriendsDailyGiftPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_friends"));
         return _loc1_;
      }
      
      public function create_dialog_friend_gifts_gmr() : FriendsDailyGiftGMRPopupClip
      {
         var _loc1_:FriendsDailyGiftGMRPopupClip = new FriendsDailyGiftGMRPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_friends_gmr"));
         return _loc1_;
      }
      
      public function create_dialog_mail() : PlayerMailPopupClip
      {
         var _loc1_:PlayerMailPopupClip = new PlayerMailPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_mail"));
         return _loc1_;
      }
      
      public function create_dialog_mail_entry() : PlayerMailEntryPopupClip
      {
         var _loc1_:PlayerMailEntryPopupClip = new PlayerMailEntryPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_mail_message"));
         return _loc1_;
      }
      
      public function create_renderer_mail() : PlayerMailRendererClip
      {
         var _loc1_:PlayerMailRendererClip = new PlayerMailRendererClip();
         _factory.create(_loc1_,data.getClipByName("mail_panel"));
         return _loc1_;
      }
      
      public function create_popup_mail_multifarm() : PlayerMailMultifarmPopupClip
      {
         var _loc1_:PlayerMailMultifarmPopupClip = new PlayerMailMultifarmPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_mail_farm_multi"));
         return _loc1_;
      }
      
      public function create_dialog_daily_bonus() : DailyBonusPopupClip
      {
         var _loc1_:DailyBonusPopupClip = new DailyBonusPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_daily_bonus"));
         return _loc1_;
      }
      
      public function create_view_daily_bonus() : DailyBonusViewClip
      {
         var _loc1_:DailyBonusViewClip = new DailyBonusViewClip();
         _factory.create(_loc1_,data.getClipByName("daily_bonus_view"));
         return _loc1_;
      }
      
      public function create_view_skin_shop() : SkinShopViewClip
      {
         var _loc1_:SkinShopViewClip = new SkinShopViewClip();
         _factory.create(_loc1_,data.getClipByName("skin_shop_view"));
         return _loc1_;
      }
      
      public function create_view_chain_event_quests() : ChainEventQuestsViewClip
      {
         var _loc1_:ChainEventQuestsViewClip = new ChainEventQuestsViewClip();
         _factory.create(_loc1_,data.getClipByName("chain_event_quests_view_sizeable"));
         return _loc1_;
      }
      
      public function create_dialog_activity() : SpecialQuestEventPopupClip
      {
         var _loc1_:SpecialQuestEventPopupClip = new SpecialQuestEventPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_activity"));
         return _loc1_;
      }
      
      public function create_renderer_daily_bonus() : DailyBonusPopupTileClip
      {
         var _loc1_:DailyBonusPopupTileClip = new DailyBonusPopupTileClip();
         _factory.create(_loc1_,data.getClipByName("renderer_daily_bonus"));
         return _loc1_;
      }
      
      public function create_event_renderer() : EventListItemRendererClip
      {
         var _loc1_:EventListItemRendererClip = new EventListItemRendererClip();
         _factory.create(_loc1_,data.getClipByName("event_renderer"));
         return _loc1_;
      }
      
      public function create_chain_quests_list_renderer() : ChainQuestsListRendererClip
      {
         var _loc1_:ChainQuestsListRendererClip = new ChainQuestsListRendererClip();
         _factory.create(_loc1_,data.getClipByName("chain_quests_list_renderer"));
         return _loc1_;
      }
      
      public function create_ny_gifts_popup_tab_renderer() : NYGiftsPopupTabRendererClip
      {
         var _loc1_:NYGiftsPopupTabRendererClip = new NYGiftsPopupTabRendererClip();
         _factory.create(_loc1_,data.getClipByName("chain_quests_list_renderer"));
         return _loc1_;
      }
      
      public function create_popup_daily_bonus_reward() : DailyBonusRewardPopupClip
      {
         var _loc1_:DailyBonusRewardPopupClip = new DailyBonusRewardPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_dailybonus_reward"));
         return _loc1_;
      }
      
      public function create_popup_daily_bonus_vip_needed() : DailyBonusPopupVipNeededClip
      {
         var _loc1_:DailyBonusPopupVipNeededClip = new DailyBonusPopupVipNeededClip();
         _factory.create(_loc1_,data.getClipByName("popup_daily_bonus_vip_needed"));
         return _loc1_;
      }
      
      public function create_popup_player_nickname_change() : PlayerNicknameChangePopupClip
      {
         var _loc1_:PlayerNicknameChangePopupClip = new PlayerNicknameChangePopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_profile_nickname"));
         return _loc1_;
      }
      
      public function create_popup_avatar_select() : AvatarSelectPopupClip
      {
         var _loc1_:AvatarSelectPopupClip = new AvatarSelectPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_profile_avatar_pick"));
         return _loc1_;
      }
      
      public function create_popup_soulshop_sell_fragments() : SoulShopSellFragmentsPopupClip
      {
         return create(SoulShopSellFragmentsPopupClip,"popup_soulshop_sell_fragments");
      }
      
      public function create_popup_soulshop_sell_fragments_not_enough() : SoulShopSellFragmentsPopupClip
      {
         return create(SoulShopSellFragmentsPopupClip,"popup_soulshop_sell_fragments_not_enough");
      }
      
      public function create_renderer_avatar_select() : AvatarPickRendererClip
      {
         var _loc1_:AvatarPickRendererClip = new AvatarPickRendererClip();
         _factory.create(_loc1_,data.getClipByName("avatar_pick_renderer"));
         return _loc1_;
      }
      
      public function create_dialog_player_profile() : PlayerProfilePopupClip
      {
         var _loc1_:PlayerProfilePopupClip = new PlayerProfilePopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_profile"));
         return _loc1_;
      }
      
      public function create_popup_multi_reward() : MultiRewardGroupedPopupClip
      {
         var _loc1_:MultiRewardGroupedPopupClip = new MultiRewardGroupedPopupClip();
         _factory.create(_loc1_,data.getClipByName("popup_multi_reward"));
         return _loc1_;
      }
      
      public function create_renderer_multi_reward() : MultiRewardRendererClip
      {
         var _loc1_:MultiRewardRendererClip = new MultiRewardRendererClip();
         _factory.create(_loc1_,data.getClipByName("renderer_multi_reward"));
         return _loc1_;
      }
      
      public function create_component_progressbar(param1:String = "hero_xp_progressbar") : ClipProgressBar
      {
         var _loc2_:ClipProgressBar = new ClipProgressBar();
         _factory.create(_loc2_,data.getClipByName(param1));
         return _loc2_;
      }
      
      public function create_dialog_settings() : SettingsPopupClip
      {
         var _loc1_:SettingsPopupClip = new SettingsPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_settings"));
         return _loc1_;
      }
      
      public function create_dialog_tower_battle_floor() : TowerBattleFloorPopupClip
      {
         var _loc1_:TowerBattleFloorPopupClip = new TowerBattleFloorPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_tower_battle_floor"));
         return _loc1_;
      }
      
      public function create_dialog_tower_chest_floor() : TowerChestFloorPopupClip
      {
         var _loc1_:TowerChestFloorPopupClip = new TowerChestFloorPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_tower_chest_floor"));
         return _loc1_;
      }
      
      public function create_dialog_tower_buff_floor() : TowerBuffFloorPopupClip
      {
         var _loc1_:TowerBuffFloorPopupClip = new TowerBuffFloorPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_tower_buff_floor"));
         return _loc1_;
      }
      
      public function create_dialog_tower_team_gather() : TowerTeamGatherClip
      {
         var _loc1_:TowerTeamGatherClip = new TowerTeamGatherClip();
         _factory.create(_loc1_,data.getClipByName("dialog_tower_team_gather"));
         return _loc1_;
      }
      
      public function create_dialog_arena_team_gather() : TowerTeamGatherClip
      {
         var _loc1_:TowerTeamGatherClip = new TowerTeamGatherClip();
         _factory.create(_loc1_,data.getClipByName("dialog_arena_team_gather"));
         return _loc1_;
      }
      
      public function create_hero_state_bars_block() : BattleGUIProgressbarBlock
      {
         var _loc1_:BattleGUIProgressbarBlock = new BattleGUIProgressbarBlock();
         _factory.create(_loc1_,data.getClipByName("hero_state_bars_block"));
         return _loc1_;
      }
      
      public function tower_hero_dead_label() : TowerTeamGatherPopupHeroRendererDeadLabelClip
      {
         var _loc1_:TowerTeamGatherPopupHeroRendererDeadLabelClip = new TowerTeamGatherPopupHeroRendererDeadLabelClip();
         _factory.create(_loc1_,data.getClipByName("tower_hero_dead_label"));
         return _loc1_;
      }
      
      public function create_tower_buff_select_hero_item() : TowerBuffSelectHeroItemClip
      {
         var _loc1_:TowerBuffSelectHeroItemClip = new TowerBuffSelectHeroItemClip();
         _factory.create(_loc1_,data.getClipByName("tower_buff_select_hero_item"));
         return _loc1_;
      }
      
      public function create_tower_buff_select_hero_dialog() : TowerBuffSelectHeroPopupClip
      {
         var _loc1_:TowerBuffSelectHeroPopupClip = new TowerBuffSelectHeroPopupClip();
         _factory.create(_loc1_,data.getClipByName("tower_buff_select_hero_dialog"));
         return _loc1_;
      }
      
      public function create_dialog_hero_runes() : HeroRunePopupClip
      {
         var _loc1_:HeroRunePopupClip = new HeroRunePopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_runes"));
         return _loc1_;
      }
      
      public function create_dialog_hero_elements() : HeroElementPopupClip
      {
         var _loc1_:HeroElementPopupClip = new HeroElementPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_hero_elements"));
         return _loc1_;
      }
      
      public function create_dialog_hero_titan_gift_level_drop() : HeroTitanGiftLevelDropPopUpClip
      {
         var _loc1_:HeroTitanGiftLevelDropPopUpClip = new HeroTitanGiftLevelDropPopUpClip();
         _factory.create(_loc1_,data.getClipByName("popup_hero_titan_gift_drop"));
         return _loc1_;
      }
      
      public function create_dialog_clan_edit_icon() : ClanEditIconPopupClip
      {
         var _loc1_:ClanEditIconPopupClip = new ClanEditIconPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_clan_edit_icon"));
         return _loc1_;
      }
      
      public function create_dialog_clan_item_for_activity() : ClanItemForActivityPopupClip
      {
         var _loc1_:ClanItemForActivityPopupClip = new ClanItemForActivityPopupClip();
         _factory.create(_loc1_,data.getClipByName("dialog_clan_item_for_activity"));
         return _loc1_;
      }
      
      public function create_dialog_hero_select() : TeamGatherPopupGuiClip
      {
         return create(TeamGatherPopupGuiClip,"dialog_hero_select");
      }
      
      public function create_dialog_dialog_grand_team_gather_defenders() : GrandTeamGatherPopupGuiClip
      {
         return create(GrandTeamGatherPopupGuiClip,"dialog_grand_team_gather_defenders");
      }
      
      public function create_dialog_dialog_grand_team_gather() : GrandTeamGatherAttackPopupGuiClip
      {
         return create(GrandTeamGatherAttackPopupGuiClip,"dialog_grand_team_gather");
      }
      
      public function create_renderer_grand_log() : GrandLogListItemRendererClip
      {
         var _loc1_:GrandLogListItemRendererClip = new GrandLogListItemRendererClip();
         _factory.create(_loc1_,data.getClipByName("dialog_grand_log_item"));
         return _loc1_;
      }
      
      public function grand_team_gather_team_label() : MultiTeamGatherTeamLabel
      {
         var _loc1_:MultiTeamGatherTeamLabel = new MultiTeamGatherTeamLabel();
         _factory.create(_loc1_,data.getClipByName("grand_team_gather_team_label"));
         return _loc1_;
      }
      
      public function grand_team_gather_hero_selector() : GuiClipNestedContainer
      {
         return create(GuiClipNestedContainer,"grand_team_gather_hero_selector");
      }
      
      public function create_dialog_victory() : MissionRewardDialogClip
      {
         return create(MissionRewardDialogClip,"dialog_victory");
      }
      
      public function create_hero_list_panel() : MissionRewardDialogHeroPanel
      {
         return create(MissionRewardDialogHeroPanel,"hero_list_panel");
      }
      
      public function create_inventory_item_icon() : InventoryItemIcon
      {
         return create(InventoryItemIcon,"inventory_item_icon");
      }
      
      public function create_dialog_defeat() : MissionDefeatPopupClip
      {
         return create(MissionDefeatPopupClip,"dialog_defeat");
      }
      
      public function create_dialog_pvp_victory() : ArenaVictoryPopupClip
      {
         return create(ArenaVictoryPopupClip,"dialog_victory_pvp");
      }
      
      public function create_hero_list_panel_pvp() : ArenaVictoryPopupHeroPanelClip
      {
         return create(ArenaVictoryPopupHeroPanelClip,"hero_list_panel_pvp");
      }
      
      public function create_dialog_reward_hero() : RewardHeroPopupClip
      {
         return create(RewardHeroPopupClip,"dialog_hero_reward");
      }
      
      public function create_dialog_reward_titan() : RewardHeroPopupClip
      {
         return create(RewardHeroPopupClip,"dialog_titan_reward");
      }
      
      public function create_dialog_hero_star_up() : HeroStarUpPopupClip
      {
         return create(HeroStarUpPopupClip,"dialog_hero_upgrade_star");
      }
      
      public function create_dialog_titan_star_up() : HeroStarUpPopupClip
      {
         return create(HeroStarUpPopupClip,"dialog_titan_upgrade_star");
      }
      
      public function create_dialog_hero_color_up() : HeroColorUpPopupClip
      {
         return create(HeroColorUpPopupClip,"dialog_hero_upgrade_color");
      }
      
      public function create_dialog_level_up() : LevelUpPopupClip
      {
         return create(LevelUpPopupClip,"dialog_level_up");
      }
      
      public function create_dialog_skin_level_up() : SkinLevelUpPopUpClip
      {
         return create(SkinLevelUpPopUpClip,"dialog_skin_level_up");
      }
      
      public function create_dialog_skin_info() : SkinInfoPopUpClip
      {
         return create(SkinInfoPopUpClip,"popup_skin_info");
      }
      
      public function create_dialog_grand_victory_single() : GrandBattleResultSinglePopupClip
      {
         return create(GrandBattleResultSinglePopupClip,"dialog_grand_victory_single");
      }
      
      public function create_dialog_grand_victory_final() : GrandBattleResultFinalPopupClip
      {
         return create(GrandBattleResultFinalPopupClip,"dialog_grand_victory_final");
      }
      
      public function create_victory_header_background() : GrandBattleResultHeaderClip
      {
         return create(GrandBattleResultHeaderClip,"victory_header_background");
      }
      
      public function create_dialog_skin_list_item() : SkinListItemClip
      {
         var _loc1_:SkinListItemClip = new SkinListItemClip();
         _factory.create(_loc1_,data.getClipByName("skin_list_item"));
         return _loc1_;
      }
      
      public function create_dialog_hero_description() : HeroDescriptionPopUpClip
      {
         var _loc1_:HeroDescriptionPopUpClip = new HeroDescriptionPopUpClip();
         _factory.create(_loc1_,data.getClipByName("popup_hero_description_info"));
         return _loc1_;
      }
      
      public function create_dialog_titan_description() : TitanDescriptionPopupClip
      {
         var _loc1_:TitanDescriptionPopupClip = new TitanDescriptionPopupClip();
         _factory.create(_loc1_,data.getClipByName("titan_description_info"));
         return _loc1_;
      }
      
      public function create_dialog_chest_reward_hero_list() : ChestRewardHeroesListPopUpClip
      {
         var _loc1_:ChestRewardHeroesListPopUpClip = new ChestRewardHeroesListPopUpClip();
         _factory.create(_loc1_,data.getClipByName("popup_chest_reward_hero_list"));
         return _loc1_;
      }
      
      public function create_dialog_chest_reward_hero_list_item() : ChestRewardHeroesListRendererClip
      {
         var _loc1_:ChestRewardHeroesListRendererClip = new ChestRewardHeroesListRendererClip();
         _factory.create(_loc1_,data.getClipByName("chest_reward_hero_list_item"));
         return _loc1_;
      }
      
      public function create_dialog_chat_user_info() : ChatUserInfoPopUpClip
      {
         var _loc1_:ChatUserInfoPopUpClip = new ChatUserInfoPopUpClip();
         _factory.create(_loc1_,data.getClipByName("popup_chat_user_info"));
         return _loc1_;
      }
      
      public function create_dialog_black_list() : BlackListPopUpClip
      {
         var _loc1_:BlackListPopUpClip = new BlackListPopUpClip();
         _factory.create(_loc1_,data.getClipByName("popup_black_list"));
         return _loc1_;
      }
   }
}
