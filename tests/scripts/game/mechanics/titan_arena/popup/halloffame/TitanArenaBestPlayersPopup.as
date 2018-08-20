package game.mechanics.titan_arena.popup.halloffame
{
   import feathers.data.ListCollection;
   import feathers.layout.TiledRowsLayout;
   import game.assets.storage.AssetStorage;
   import game.mechanics.titan_arena.mediator.halloffame.TitanArenaBestPlayersPopupMediator;
   import game.view.gui.components.GameScrollBar;
   import game.view.gui.components.GameScrolledList;
   import game.view.popup.ClipBasedPopup;
   
   public class TitanArenaBestPlayersPopup extends ClipBasedPopup
   {
       
      
      private var mediator:TitanArenaBestPlayersPopupMediator;
      
      private var clip:TitanArenaBestPlayersPopupClip;
      
      private var list:GameScrolledList;
      
      public function TitanArenaBestPlayersPopup(param1:TitanArenaBestPlayersPopupMediator)
      {
         super(param1);
         this.mediator = param1;
      }
      
      override protected function initialize() : void
      {
         super.initialize();
         clip = AssetStorage.rsx.dialog_titan_arena.create(TitanArenaBestPlayersPopupClip,"dialog_titan_arena_best_players");
         addChild(clip.graphics);
         width = clip.dialog_frame.graphics.width;
         height = clip.dialog_frame.graphics.height;
         clip.title = mediator.title;
         clip.button_close.signal_click.add(mediator.close);
         var _loc1_:GameScrollBar = new GameScrollBar();
         _loc1_.height = clip.scroll_slider_container.graphics.height;
         clip.scroll_slider_container.container.addChild(_loc1_);
         list = new GameScrolledList(_loc1_,null,null);
         list.layout = new TiledRowsLayout();
         (list.layout as TiledRowsLayout).useVirtualLayout = true;
         (list.layout as TiledRowsLayout).useSquareTiles = false;
         (list.layout as TiledRowsLayout).horizontalGap = 5;
         (list.layout as TiledRowsLayout).verticalGap = 5;
         (list.layout as TiledRowsLayout).paddingTop = 5;
         (list.layout as TiledRowsLayout).paddingBottom = 5;
         list.width = clip.list_container.width;
         list.height = clip.list_container.height;
         list.itemRendererType = TitanArenaHallOfFameBestPlayerRenderer;
         list.dataProvider = new ListCollection(mediator.list);
         clip.list_container.addChild(list);
      }
   }
}
