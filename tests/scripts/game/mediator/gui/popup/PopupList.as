package game.mediator.gui.popup
{
   import com.progrestar.common.lang.Translate;
   import game.command.rpc.player.server.ServerListUserValueObject;
   import game.data.storage.artifact.ArtifactDescription;
   import game.data.storage.artifact.TitanArtifactDescription;
   import game.data.storage.hero.HeroDescription;
   import game.data.storage.hero.UnitDescription;
   import game.data.storage.level.PlayerTeamLevel;
   import game.data.storage.resource.InventoryItemDescription;
   import game.data.storage.resource.ObtainNavigatorType;
   import game.data.storage.titan.TitanDescription;
   import game.mediator.gui.popup.artifacts.HeroArtifactsPopupMediator;
   import game.mediator.gui.popup.artifacts.TitanArtifactsPopupMediator;
   import game.mediator.gui.popup.billing.BillingPopupMediator;
   import game.mediator.gui.popup.clan.ClanEnterCooldownPopupMediator;
   import game.mediator.gui.popup.clan.ClanValueObject;
   import game.mediator.gui.popup.hero.HeroArtifactListPopupMediator;
   import game.mediator.gui.popup.hero.HeroElementPopupMediator;
   import game.mediator.gui.popup.hero.HeroListPopupMediator;
   import game.mediator.gui.popup.hero.HeroPopupMediator;
   import game.mediator.gui.popup.hero.HeroRuneListPopupMediator;
   import game.mediator.gui.popup.hero.HeroUseConsumableWithSelectorPopupMediator;
   import game.mediator.gui.popup.hero.HeroUseXPConsumableNotEnoughPopupMediator;
   import game.mediator.gui.popup.hero.evolve.HeroEvolveCostPopupMediator;
   import game.mediator.gui.popup.hero.skin.SkinInfoPopUpMediator;
   import game.mediator.gui.popup.hero.skin.SkinLevelUpPopUpMediator;
   import game.mediator.gui.popup.inventory.ItemInfoPopupMediator;
   import game.mediator.gui.popup.player.LevelUpPopupMediator;
   import game.mediator.gui.popup.quest.QuestListPopupMediator;
   import game.mediator.gui.popup.rating.RatingPopupMediator;
   import game.mediator.gui.popup.rune.HeroRunePopupMediator;
   import game.mediator.gui.popup.shop.soul.SoulShopSellFragmentsPopupMediator;
   import game.mediator.gui.popup.shop.titansoul.TitanSoulShopSellFragmentsPopupMediator;
   import game.mediator.gui.popup.titan.TitanListPopupMediator;
   import game.mediator.gui.popup.titan.TitanPopupMediator;
   import game.mediator.gui.popup.titan.evolve.TitanEvolveCostPopupMediator;
   import game.mediator.gui.popup.titanspiritartifact.TitanSpiritArtifactPopupMediator;
   import game.model.GameModel;
   import game.model.user.hero.PlayerHeroEntry;
   import game.model.user.hero.PlayerTitanArtifact;
   import game.model.user.hero.PlayerTitanEntry;
   import game.model.user.inventory.InventoryItem;
   import game.stat.Stash;
   import game.view.popup.MessagePopup;
   import game.view.popup.MessageWideButtonPopup;
   import game.view.popup.PopupBase;
   import game.view.popup.PromptPopup;
   import game.view.popup.artifactinfo.ArtifactInfoPopupMediator;
   import game.view.popup.artifactinfo.ArtifactRecipeItemInfoPopupMediator;
   import game.view.popup.artifactinfo.TitanArtifactInfoPopupMediator;
   import game.view.popup.artifactinfo.TitanSpiritArtifactInfoPopupMediator;
   import game.view.popup.herodescription.HeroDescriptionPopUpMediator;
   import game.view.popup.merge.ConfirmMergeAccountsPopUpMediator;
   import game.view.popup.merge.MergeInfoPopUpMediator;
   import game.view.popup.message.ErrorPopup;
   import game.view.popup.refillable.NotEnoughVipPopup;
   import game.view.popup.resource.NotEnoughResourcePopupMediator;
   import game.view.popup.selectaccount.SelectAccountPopUpMediator;
   
   public class PopupList
   {
      
      private static var _instance:PopupList;
       
      
      public function PopupList()
      {
         super();
      }
      
      public static function get instance() : PopupList
      {
         if(!_instance)
         {
            _instance = new PopupList();
         }
         return _instance;
      }
      
      public function dialog_dailyQuests(param1:PopupStashEventParams) : void
      {
         var _loc2_:QuestListPopupMediator = new QuestListPopupMediator(GameModel.instance.player,1);
         _loc2_.open(Stash.click("quests_daily",param1));
      }
      
      public function dialog_bank(param1:PopupStashEventParams) : void
      {
         var _loc3_:* = null;
         var _loc2_:BillingPopupMediator = new BillingPopupMediator(GameModel.instance.player);
         if(param1)
         {
            _loc3_ = Stash.click("bank_gems",param1);
         }
         _loc2_.open(_loc3_);
      }
      
      public function dialog_hero(param1:HeroDescription, param2:String = null) : HeroPopupMediator
      {
         var _loc4_:PlayerHeroEntry = GameModel.instance.player.heroes.getById(param1.id);
         var _loc3_:HeroPopupMediator = new HeroPopupMediator(GameModel.instance.player,_loc4_);
         if(param2)
         {
            _loc3_.tabSelected = param2;
         }
         _loc3_.open();
         return _loc3_;
      }
      
      public function dialog_titan(param1:TitanDescription) : void
      {
         var _loc2_:* = null;
         var _loc3_:PlayerTitanEntry = GameModel.instance.player.titans.getById(param1.id);
         if(TitanPopupMediator.current)
         {
            GamePopupManager.instance.removePopUp(TitanPopupMediator.current.popup);
            TitanPopupMediator.current.titan = _loc3_;
            GamePopupManager.instance.addPopUp(TitanPopupMediator.current.popup);
         }
         else
         {
            _loc2_ = new TitanPopupMediator(GameModel.instance.player,_loc3_);
            _loc2_.open();
         }
      }
      
      public function dialog_titan_list(param1:PopupStashEventParams) : void
      {
         var _loc2_:TitanListPopupMediator = new TitanListPopupMediator(GameModel.instance.player);
         _loc2_.open(null);
      }
      
      public function dialog_hero_description(param1:HeroDescription, param2:Boolean, param3:PopupStashEventParams) : void
      {
         var _loc4_:HeroDescriptionPopUpMediator = new HeroDescriptionPopUpMediator(GameModel.instance.player,param1,param2);
         _loc4_.open(param3);
      }
      
      public function popup_hero_evolve_cost(param1:HeroDescription) : HeroEvolveCostPopupMediator
      {
         var _loc2_:HeroEvolveCostPopupMediator = new HeroEvolveCostPopupMediator(GameModel.instance.player,param1);
         _loc2_.open();
         return _loc2_;
      }
      
      public function popup_titan_evolve_cost(param1:TitanDescription) : TitanEvolveCostPopupMediator
      {
         var _loc2_:TitanEvolveCostPopupMediator = new TitanEvolveCostPopupMediator(GameModel.instance.player,param1);
         _loc2_.open();
         return _loc2_;
      }
      
      public function prompt(param1:String, param2:String, param3:String, param4:String) : PromptPopup
      {
         var _loc5_:PromptPopup = new PromptPopup(param1,param2,param3,param4);
         _loc5_.open();
         return _loc5_;
      }
      
      public function message(param1:String, param2:String = "", param3:Boolean = false) : MessagePopup
      {
         var _loc4_:MessagePopup = new MessagePopup(param1,param2,param3);
         _loc4_.open();
         return _loc4_;
      }
      
      public function error(param1:String, param2:String = "", param3:Boolean = false) : void
      {
         new ErrorPopup(param1,param2,param3).open();
      }
      
      public function dialog_not_enough_resource(param1:ObtainNavigatorType, param2:PopupStashEventParams = null) : void
      {
         new NotEnoughResourcePopupMediator(param1).open(Stash.click("command",param2));
      }
      
      public function dialog_no_titans(param1:PopupStashEventParams = null) : void
      {
         message(Translate.translateArgs("UI_DUNGEON_NO_TITANS",2),"");
      }
      
      public function dialog_not_enough_titan_consumable(param1:String, param2:String = "", param3:String = "") : MessageWideButtonPopup
      {
         var _loc4_:MessageWideButtonPopup = new MessageWideButtonPopup(param1,param2,param3);
         _loc4_.open();
         return _loc4_;
      }
      
      public function dialog_level_up(param1:PlayerTeamLevel, param2:PlayerTeamLevel) : void
      {
         var _loc3_:LevelUpPopupMediator = new LevelUpPopupMediator(GameModel.instance.player,param1,param2);
         _loc3_.open();
      }
      
      public function dialog_skin_level_up(param1:uint) : void
      {
         var _loc2_:SkinLevelUpPopUpMediator = new SkinLevelUpPopUpMediator(GameModel.instance.player,param1);
         _loc2_.open();
      }
      
      public function dialog_skin_info(param1:uint) : void
      {
         var _loc2_:SkinInfoPopUpMediator = new SkinInfoPopUpMediator(GameModel.instance.player,param1);
         _loc2_.open();
      }
      
      public function dialog_hero_add_exp(param1:PlayerHeroEntry = null, param2:InventoryItem = null) : void
      {
         var _loc4_:HeroUseConsumableWithSelectorPopupMediator = new HeroUseConsumableWithSelectorPopupMediator(GameModel.instance.player,param1,param2);
         var _loc3_:PopupBase = _loc4_.createPopup();
         if(_loc3_)
         {
            _loc3_.open();
         }
      }
      
      public function dialog_hero_add_exp_not_enough() : void
      {
         var _loc1_:HeroUseXPConsumableNotEnoughPopupMediator = new HeroUseXPConsumableNotEnoughPopupMediator(GameModel.instance.player);
         _loc1_.open();
      }
      
      public function popup_item_info(param1:InventoryItemDescription = null, param2:HeroDescription = null, param3:PopupStashEventParams = null) : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(param1 is ArtifactDescription)
         {
            _loc7_ = new ArtifactInfoPopupMediator(GameModel.instance.player,param1 as ArtifactDescription,param2);
            _loc7_.open(param3);
         }
         else if(param1 is TitanArtifactDescription)
         {
            if((param1 as TitanArtifactDescription).artifactType == "spirit" || (param1 as TitanArtifactDescription).artifactType == "amulet")
            {
               _loc6_ = new TitanSpiritArtifactInfoPopupMediator(GameModel.instance.player,param1 as TitanArtifactDescription);
               _loc6_.open(param3);
            }
            else
            {
               _loc5_ = new TitanArtifactInfoPopupMediator(GameModel.instance.player,param1 as TitanArtifactDescription);
               _loc5_.open(param3);
            }
         }
         else
         {
            _loc4_ = new ItemInfoPopupMediator(GameModel.instance.player,param1);
            _loc4_.open(param3);
         }
      }
      
      public function popup_artifact_recipe_item_info(param1:InventoryItemDescription = null, param2:UnitDescription = null, param3:PopupStashEventParams = null) : void
      {
         var _loc7_:* = null;
         var _loc6_:* = null;
         var _loc5_:* = null;
         var _loc4_:* = null;
         if(param1 is ArtifactDescription)
         {
            _loc7_ = new ArtifactInfoPopupMediator(GameModel.instance.player,param1 as ArtifactDescription,param2 as HeroDescription);
            _loc7_.open(param3);
         }
         else if(param1 is TitanArtifactDescription)
         {
            if((param1 as TitanArtifactDescription).artifactType == "spirit" || (param1 as TitanArtifactDescription).artifactType == "amulet")
            {
               _loc6_ = new TitanSpiritArtifactInfoPopupMediator(GameModel.instance.player,param1 as TitanArtifactDescription);
               _loc6_.open(param3);
            }
            else
            {
               _loc5_ = new TitanArtifactInfoPopupMediator(GameModel.instance.player,param1 as TitanArtifactDescription);
               _loc5_.open(param3);
            }
         }
         else
         {
            _loc4_ = new ArtifactRecipeItemInfoPopupMediator(GameModel.instance.player,param1);
            _loc4_.open(param3);
         }
      }
      
      public function dialog_hero_list(param1:PopupStashEventParams) : void
      {
         var _loc2_:HeroListPopupMediator = new HeroListPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      public function dialog_hero_rune_list(param1:PopupStashEventParams) : void
      {
         var _loc2_:HeroRuneListPopupMediator = new HeroRuneListPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      public function dialog_hero_artifact_list(param1:PopupStashEventParams) : void
      {
         var _loc2_:HeroArtifactListPopupMediator = new HeroArtifactListPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
      }
      
      public function popup_vip_needed(param1:String, param2:int) : void
      {
         var _loc3_:NotEnoughVipPopup = new NotEnoughVipPopup(param1,param2);
         _loc3_.open();
      }
      
      public function dialog_rating(param1:PopupStashEventParams) : RatingPopupMediator
      {
         var _loc2_:RatingPopupMediator = new RatingPopupMediator(GameModel.instance.player);
         _loc2_.open(param1);
         return _loc2_;
      }
      
      public function dialog_runes(param1:HeroDescription, param2:PopupStashEventParams) : void
      {
         var _loc3_:HeroRunePopupMediator = new HeroRunePopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
      }
      
      public function dialog_elements(param1:HeroDescription, param2:PopupStashEventParams) : void
      {
         var _loc3_:HeroElementPopupMediator = new HeroElementPopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
      }
      
      public function dialog_artifacts(param1:HeroDescription, param2:ArtifactDescription, param3:PopupStashEventParams) : void
      {
         var _loc4_:HeroArtifactsPopupMediator = new HeroArtifactsPopupMediator(GameModel.instance.player,param2,param1);
         _loc4_.open(param3);
      }
      
      public function dialog_titan_artifacts(param1:TitanDescription, param2:TitanArtifactDescription, param3:PopupStashEventParams) : void
      {
         var _loc4_:TitanArtifactsPopupMediator = new TitanArtifactsPopupMediator(GameModel.instance.player,param2,param1);
         _loc4_.open(param3);
      }
      
      public function dialog_titan_spirit_artifacts(param1:PlayerTitanArtifact, param2:PopupStashEventParams) : void
      {
         var _loc3_:TitanSpiritArtifactPopupMediator = new TitanSpiritArtifactPopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
      }
      
      public function popup_clan_enter_cooldown(param1:ClanValueObject, param2:PopupStashEventParams) : ClanEnterCooldownPopupMediator
      {
         var _loc3_:ClanEnterCooldownPopupMediator = new ClanEnterCooldownPopupMediator(param1,GameModel.instance.player);
         _loc3_.open(param2);
         return _loc3_;
      }
      
      public function dialog_soulshop_sell_fragments(param1:Boolean, param2:PopupStashEventParams) : void
      {
         var _loc3_:SoulShopSellFragmentsPopupMediator = new SoulShopSellFragmentsPopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
      }
      
      public function dialog_titan_soulshop_sell_fragments(param1:Boolean, param2:PopupStashEventParams) : void
      {
         var _loc3_:TitanSoulShopSellFragmentsPopupMediator = new TitanSoulShopSellFragmentsPopupMediator(GameModel.instance.player,param1);
         _loc3_.open(param2);
      }
      
      public function dialog_select_account(param1:Array) : void
      {
         var _loc2_:SelectAccountPopUpMediator = new SelectAccountPopUpMediator(param1);
         _loc2_.open();
      }
      
      public function dialog_confirm_merge_accounts(param1:ServerListUserValueObject, param2:Array) : void
      {
         var _loc3_:ConfirmMergeAccountsPopUpMediator = new ConfirmMergeAccountsPopUpMediator(param1,param2);
         _loc3_.open();
      }
      
      public function dialog_merge_info(param1:Array, param2:Boolean = false) : void
      {
         var _loc3_:MergeInfoPopUpMediator = new MergeInfoPopUpMediator(GameModel.instance.player,param1);
         if(!param2)
         {
            _loc3_.open();
         }
         else
         {
            _loc3_.openDelayed();
         }
      }
   }
}
