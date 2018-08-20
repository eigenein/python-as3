package game.mechanics.titan_arena.popup.trophies
{
   import com.progrestar.common.lang.Translate;
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.mediator.trophies.TitanArenaTrophiesPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaTrophiesPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaTrophiesPopupMediator;
      
      private var clip:TitanArenaTrophiesPopupClip;
      
      private var list:GameScrolledList;
      
      public function TitanArenaTrophiesPopup(param1:TitanArenaTrophiesPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaTrophiesPopupClip,"dialog_titan_arena_trophies");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = Translate.translate("UI_DIALOG_TITAN_ARENA_TROPHIES_TITLE");
         clip.button_close.signal_click.add(mediator.close);
         clip.tf_desc.text = Translate.translate("UI_DIALOG_TITAN_ARENA_TROPHIES_DESC");
         clip.btn_tournament.label = Translate.translate("UI_DIALOG_TITAN_ARENA_TROPHIES_TOURNAMENT");
         clip.btn_tournament.signal_click.add(mediator.action_navigate_arena);
         clip.tf_empty.text = Translate.translate("UI_DIALOG_TITAN_ARENA_TROPHIES_EMPTY");
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new GameScrolledList(_loc1_,null,null);
         list.layout = new TiledRowsLayout();
         (list.layout as TiledRowsLayout).useVirtualLayout = true;
         (list.layout as TiledRowsLayout).useSquareTiles = false;
         (list.layout as TiledRowsLayout).horizontalGap = 5;
         (list.layout as TiledRowsLayout).verticalGap = 5;
         list.width = clip.list_container.width;
         list.height = clip.list_container.height;
         list.itemRendererType = TitanArenaHallOfFameTrophyRenderer;
         list.dataProvider = new ListCollection(mediator.getTrophyList());
         clip.list_container.addChild(list);
         clip.tf_empty.visible = list.dataProvider.length == 0;
      }
   }
}
