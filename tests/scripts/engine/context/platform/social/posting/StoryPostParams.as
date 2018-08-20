package engine.context.platform.social.posting
{
   public class StoryPostParams
   {
       
      
      var _object:String;
      
      var _action:String;
      
      var _objectId:int;
      
      var _objectDescription:String;
      
      var _image:String;
      
      var _actionDescription:String;
      
      var _actionParam:String;
      
      public function StoryPostParams()
      {
         super();
      }
      
      public function get ident() : String
      {
         return _action + "_" + _object;
      }
      
      public function get object() : String
      {
         return _object;
      }
      
      public function get action() : String
      {
         return _action;
      }
      
      public function get objectId() : int
      {
         return _objectId;
      }
      
      public function get objectDescription() : String
      {
         return _objectDescription;
      }
      
      public function get image() : String
      {
         return _image;
      }
      
      public function get actionDescription() : String
      {
         return _actionDescription;
      }
      
      public function get actionParam() : String
      {
         return _actionParam;
      }
   }
}
