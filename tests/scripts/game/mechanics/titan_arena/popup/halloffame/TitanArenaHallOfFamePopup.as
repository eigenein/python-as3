package game.mechanics.titan_arena.popup.halloffame
{
   import com.progrestar.common.lang.Translate;
   import engine.core.assets.AssetList;
   import engine.core.assets.RequestableAsset;
   import engine.core.clipgui.ClipSprite;
   import engine.core.clipgui.GuiAnimation;
   import feathers.controls.LayoutGroup;
   import feathers.layout.TiledRowsLayout;
   import feathers.layout.VerticalLayout;
   import game.assets.storage.AssetStorage;
   import game.assets.storage.rsx.RsxGuiAsset;
   import game.mechanics.titan_arena.mediator.halloffame.TitanArenaHallOfFamePopupMediator;
   import game.mechanics.titan_arena.model.TitanArenaHallOfFameVO;
   import game.util.DateFormatter;
   import game.view.gui.components.ClipButtonLabeled;
   import game.view.gui.components.ClipLayout;
   import game.view.gui.components.GameLabel;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrollContainer;
   import game.view.popup.AsyncClipBasedPopupWithPreloader;
   import game.view.popup.chest.ChestPopupTitle;
   import game.view.popup.theme.LabelStyle;
   
   public class TitanArenaHallOfFamePopup extends AsyncClipBasedPopupWithPreloader
   {
       
      
      private var mediator:TitanArenaHallOfFamePopupMediator;
      
      private var clip:TitanArenaHallOfFamePopupClip;
      
      private var scrollContainer:GameScrollContainer;
      
      private var content:ClipLayout;
      
      private var tournamentRenderer:TitanArenaHallOfFameTournamentRenderer;
      
      private var popupTitle:ChestPopupTitle;
      
      private var _progressAsset:RequestableAsset;
      
      public function TitanArenaHallOfFamePopup(param1:TitanArenaHallOfFamePopupMediator)
      {
         super(param1,AssetStorage.rsx.dialog_titan_arena);
         this.mediator = param1;
         this.mediator.signal_infoUpdate.add(handler_infoUpdate);
         var _loc2_:AssetList = new AssetList();
         _loc2_.addAssets(AssetStorage.rsx.dialog_titan_arena);
         _progressAsset = _loc2_;
         AssetStorage.instance.globalLoader.requestAsset(_loc2_);
      }
      
      override public function dispose() : void
      {
         this.mediator.signal_infoUpdate.remove(handler_infoUpdate);
         super.dispose();
      }
      
      override protected function get progressAsset() : RequestableAsset
      {
         return _progressAsset;
      }
      
      override protected function onAssetLoaded(param1:RsxGuiAsset) : void
      {
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaHallOfFamePopupClip,"dialog_titan_arena_hall_of_frame");
         addChild(clip.graphics);
         width = 1000;
         height = 650;
         popupTitle = new ChestPopupTitle(Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_TITLE"),clip.header_layout_container);
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_loading.text = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_LOADING");
         clip.btn_cups.label = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_MY_CUPS");
         clip.btn_cups.signal_click.add(mediator.action_showMyTrophies);
         clip.btn_rules.label = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_RULES");
         clip.btn_rules.signal_click.add(mediator.action_showTitanArenaRules);
         tournamentRenderer = new TitanArenaHallOfFameTournamentRenderer();
         clip.top_list_container.addChild(tournamentRenderer);
         var _loc2_:GameScrollBar = new GameScrollBar();
         _loc2_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc2_);
         scrollContainer = new GameScrollContainer(_loc2_,null,null);
         (scrollContainer.layout as VerticalLayout).horizontalAlign = "center";
         (scrollContainer.layout as VerticalLayout).gap = 8;
         scrollContainer.width = clip.list_container.graphics.width;
         scrollContainer.height = clip.list_container.graphics.height;
         clip.list_container.addChild(scrollContainer);
         content = ClipLayout.verticalCenter(10);
         scrollContainer.addChild(content);
         clip.arrow_left.graphics.visible = false;
         clip.arrow_right.graphics.visible = false;
         clip.arrow_left.signal_click.add(handler_arrowLeftClick);
         clip.arrow_right.signal_click.add(handler_arrowRightClick);
         updateContent(mediator.currentInfo);
      }
      
      private function updateContent(param1:TitanArenaHallOfFameVO) : void
      {
         var _loc8_:* = null;
         var _loc2_:* = null;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc9_:* = null;
         var _loc10_:* = null;
         var _loc11_:* = null;
         var _loc7_:int = 0;
         var _loc3_:* = null;
         clip.arrow_left.graphics.visible = param1.prev > 0;
         clip.arrow_right.graphics.visible = param1.next > 0;
         clip.tf_loading.visible = false;
         var _loc4_:Date = new Date(param1.key * 1000);
         tournamentRenderer.data = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_TOURNAMENT") + " " + DateFormatter.dateToDDMMYYYY(_loc4_);
         addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_WINNERS"));
         addText(LabelStyle.createLabel(18,16770485,"center"),Translate.translateArgs("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_DATE",DateFormatter.dateToDDMMYYYY(_loc4_)));
         if(param1.champions && param1.champions.length > 0)
         {
            addSpacer(10);
            addCupAnimation("cup_1_animation_with_bg");
            addSpacer(-16);
            addLine();
            addText(LabelStyle.createLabel(24,15919178,"center"),Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_CHAMPION"));
            _loc8_ = new TitanArenaHallOfFameChampionRenderer();
            _loc8_.data = param1.champions[0];
            content.addChild(_loc8_);
         }
         if(param1.champions && param1.champions.length > 1)
         {
            addSpacer(10);
            addCupAnimation("cup_2_animation_with_bg");
            addSpacer(-16);
            addLine();
            addText(LabelStyle.createLabel(24,15919178,"center"),Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_GOLD_CUPS_HOLDERS"));
            _loc2_ = new LayoutGroup();
            _loc2_.layout = new TiledRowsLayout();
            (_loc2_.layout as TiledRowsLayout).useSquareTiles = false;
            (_loc2_.layout as TiledRowsLayout).horizontalGap = 5;
            (_loc2_.layout as TiledRowsLayout).verticalGap = 5;
            _loc2_.width = clip.list_container.graphics.width;
            content.addChild(_loc2_);
            _loc5_ = 1;
            while(_loc5_ < int(Math.min(mediator.maxDisplayedRenderers + 1,param1.champions.length)))
            {
               _loc6_ = new TitanArenaHallOfFameGoldCupHolderRenderer();
               _loc6_.data = param1.champions[_loc5_];
               _loc2_.addChild(_loc6_);
               _loc5_++;
            }
            if(param1.champions.length > mediator.maxDisplayedRenderers)
            {
               _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_180");
               _loc9_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_SHOW_ALL");
               _loc9_.signal_click.add(mediator.action_showGoldCupHolderPlayers);
               content.addChild(_loc9_.container);
            }
         }
         if(param1.bestOnServer)
         {
            addSpacer(10);
            addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_BEST_SERVER_PLAYER"));
            addText(LabelStyle.createLabel(18,16770485,"center"),mediator.serverName);
            _loc10_ = new TitanArenaHallOfFameBestPlayerRenderer();
            _loc10_.data = param1.bestOnServer;
            content.addChild(_loc10_);
         }
         if(param1.bestGuildMembers && param1.bestGuildMembers.length > 0)
         {
            addSpacer(10);
            addText(LabelStyle.label_size24_beige_center(),Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_BEST_GUILD_PLAYERS"));
            _loc11_ = new LayoutGroup();
            _loc11_.layout = new TiledRowsLayout();
            (_loc11_.layout as TiledRowsLayout).useSquareTiles = false;
            (_loc11_.layout as TiledRowsLayout).horizontalGap = 5;
            (_loc11_.layout as TiledRowsLayout).verticalGap = 5;
            _loc11_.width = clip.list_container.graphics.width;
            content.addChild(_loc11_);
            _loc7_ = 0;
            while(_loc7_ < int(Math.min(mediator.maxDisplayedRenderers,param1.bestGuildMembers.length)))
            {
               _loc3_ = new TitanArenaHallOfFameBestPlayerRenderer();
               _loc3_.data = param1.bestGuildMembers[_loc7_];
               _loc11_.addChild(_loc3_);
               _loc7_++;
            }
            if(param1.bestGuildMembers.length > mediator.maxDisplayedRenderers)
            {
               _loc9_ = AssetStorage.rsx.popup_theme.create(ClipButtonLabeled,"green_labeled_button_180");
               _loc9_.label = Translate.translate("UI_DIALOG_TITAN_ARENA_HALL_OF_FAME_SHOW_ALL");
               _loc9_.signal_click.add(mediator.action_showBestGuildMembers);
               content.addChild(_loc9_.container);
            }
         }
      }
      
      private function addSpacer(param1:Number) : void
      {
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.height = param1;
         content.addChild(_loc2_);
      }
      
      private function addLine() : void
      {
         var _loc1_:ClipSprite = AssetStorage.rsx.dialog_titan_arena.create(ClipSprite,"alchemy_shinyLine");
         _loc1_.graphics.width = 700;
         content.addChild(_loc1_.graphics);
      }
      
      private function addCupAnimation(param1:String) : void
      {
         var _loc2_:LayoutGroup = new LayoutGroup();
         _loc2_.height = 230;
         content.addChild(_loc2_);
         var _loc3_:GuiAnimation = AssetStorage.rsx.dialog_titan_arena.create(GuiAnimation,param1);
         _loc2_.addChild(_loc3_.graphics);
      }
      
      private function addText(param1:GameLabel, param2:String) : void
      {
         param1.width = scrollContainer.width;
         param1.text = param2;
         content.addChild(param1);
      }
      
      private function handler_arrowLeftClick() : void
      {
         content.removeChildren(0,-1,true);
         scrollContainer.verticalScrollPosition = 0;
         clip.tf_loading.visible = true;
         clip.arrow_left.graphics.visible = false;
         clip.arrow_right.graphics.visible = false;
         mediator.action_getPrevHallOfFameGet();
      }
      
      private function handler_arrowRightClick() : void
      {
         content.removeChildren(0,-1,true);
         scrollContainer.verticalScrollPosition = 0;
         clip.tf_loading.visible = true;
         clip.arrow_left.graphics.visible = false;
         clip.arrow_right.graphics.visible = false;
         mediator.action_getNextHallOfFameGet();
      }
      
      private function handler_infoUpdate(param1:TitanArenaHallOfFameVO) : void
      {
         updateContent(param1);
      }
   }
}
