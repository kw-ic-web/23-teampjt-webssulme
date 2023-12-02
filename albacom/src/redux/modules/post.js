import { createAction, handleActions } from "redux-actions";
import { produce } from "immer";
import { config } from "../../shared/config";
import moment from "moment";

import axios from "axios";

const SET_POST = "SET_POST"; // 게시글 목록 불러오기 => postlistpage
const ADD_POST = "ADD_POST"; // 게시글 작성 => createpostpage
const GET_POST = "GET_POST"; // 게시글 상세 불러오기  => postdetailpage
const DELETE_POST = "DELETE_POST"; // 게시글 삭제
const EDIT_POST = "EDIT_POST"; // 게시글 수정 => editpost


const setPost = createAction(SET_POST, (post_list, text) => ({
  post_list,
  text,
}));
const addPost = createAction(ADD_POST, (post) => ({ post }));
const getPost = createAction(GET_POST, (post, is_like) => ({ post, is_like }));
const deletePost = createAction(DELETE_POST, (post) => ({ post }));
const editPost = createAction(EDIT_POST, (post) => ({ post }));


const initialState = {
  list: [],
  post: [],
  text: null,
};

const setPostDB = (text = null, page = 1) => {
  return function (dispatch, getState, { history }) {
    // 카테고리 값이 없으면 전체 목록 보여주기
    if (text === null) {
      axios({
        method: "get",
        url: `${config.api}/post?page=${page}`,
      }).then((docs) => {
        const post_list = docs.data;
        // console.log(post_list);

        // 페이지 이동 시, 포스트가 하나라도 없다면
        if (post_list.post.length === 0) {
          window.alert("마지막 페이지입니다");
          return;
        }
        dispatch(setPost(post_list));
      });
      
      // 카테고리별로 보여주기
    } else {
      axios({
        method: "get",
        url: `${config.api}/post/${text}`,
      }).then((docs) => {
        const post_list = docs.data;
        // console.log(post_list);
        if (post_list.post.length === 0) {
          window.alert("마지막 페이지입니다");
          return;
        }
        dispatch(setPost(post_list, text));
      });
    }
  };
};


const addPostDB = (title, content, category, username) => {
  return function (dispatch, getState, { history }) {
    // 이미지가 포함되어있기때문에 formdata로 서버와 소통한다.
    let formdata = new FormData();
    formdata.append("title", title);
    formdata.append("content", content);
    formdata.append("category", category);
    formdata.append("user", username);

    // // formdata 내부 확인하는 방법
    // for (var key of formdata.keys()) {
    //   console.log(key);
    // }
    // for (var value of formdata.values()) {
    //   console.log(value);
    // }


    
    axios({
      method: "post",
      url: `${config.api}/post/write`,
      data: formdata,
      header: {
        "Content-Type": "multipart/form-data",
      },
    }).then((res) => {
      console.log(res);
      const new_post = {
        title: res.data.newPost.title,
        category: res.data.newPost.category,
        content: res.data.newPost.content,
        createdAt: moment().format("YYYY-MM-DD HH:mm:ss"),
        recommendCnt: res.data.newPost.recommendCnt,
        comment: res.data.newPost.comment,
        recommendUser: res.data.newPost.recommendUser,
        user: res.data.newPost.user,
      };
      dispatch(addPost(new_post));
    });
  };
};



const getOnePostDB = (id) => {
  return function (dispatch, getState, { history }) {
    // 좋아요 상태 state 값에서 가져오기
    let is_like = getState().post.is_like;

    // 로그인한 유저의 정보 state 값에서 가져오기
    let _user = getState().user.user;

    axios({
      method: "get",
      url: `${config.api}/post/detail/${id}`,
    })
      .then((docs) => {
        // console.log(docs.data);
        const onePost = docs.data.post;
        // console.log(onePost);

        // 좋아요 버튼 상황별 활성화 위해 is_like로 현재 좋아요 상태 체크 할 것임
        // 좋아요한 유저리스트에 정보가 없으면 is_like는 비활성화상태(false) 있으면 활성화(true)
        // console.log(_user.id);
        is_like =
          onePost.recommendUser.findIndex((p) => p === _user.id) === -1
            ? false
            : true;

        dispatch(getPost(onePost, is_like));
      })
      .catch((err) => {
        console.log("에러", err);
      });
  };
};

const editPostDB = (content, title, id) => {
  return function (dispatch, getState, { history }) {
    axios({
      method: "patch",
      url: `${config.api}/post/${id}`,
      data: {
        content: content,
        title: title,
      },
    })
      .then(() => {
        let new_post_data = {
          // 새로 받은 값들로 덮어쓰기한다.
          title: title,
          _id: id,
          content: content,
        };
        // console.log(new_post_data);
        dispatch(editPost(new_post_data));
        window.alert("수정 되었습니다!");
      })
      .catch((err) => {
        console.log("수정에러", err);
      });
  };
};

// 게시글 DB에서 삭제
const deletePostDB = (id) => {
  return function (dispatch, getState, { history }) {
    axios({
      method: "delete",
      url: `${config.api}/post/${id}`,
      data: {
        _id: id,
      },
    })
      .then((res) => {
        // console.log(res);
        dispatch(deletePost(id));
      })
      .catch((err) => {
        console.log("삭제에러", err);
      });
  };
};



// 리듀서
export default handleActions(
  {
    [SET_POST]: (state, action) =>
      produce(state, (draft) => {
        draft.list = action.payload.post_list.post;
        draft.text = action.payload.text;
      }),
    [ADD_POST]: (state, action) =>
      produce(state, (draft) => {
        console.log(action.payload.post);
        const new_post = action.payload.post;
        draft.list.unshift(new_post);
      }),

    [GET_POST]: (state, action) =>
      produce(state, (draft) => {
        console.log(action.payload);
        draft.post = action.payload.post;
        draft.is_like = action.payload.is_like;
      }),

    [DELETE_POST]: (state, action) =>
      produce(state, (draft) => {
        // 받아온 id값과 맞지 않는 id의 데이터들을 새로운 배열에 넣어서 기존 list에 덮어쓰기해준다.
        
        const new_post_list = draft.list.filter((p) => p.id !== action.payload.post);
        draft.list = new_post_list; // 새롭게 바뀐 리스트를 현재의 리스트로 변경
      }),
    [EDIT_POST]: (state, action) =>
      produce(state, (draft) => {
        // 수정할 포스트의 id로 인덱스를 찾는다.
        const idx = draft.list.findIndex(
          (p) => p._id === action.payload.post._id
        );
        draft.post = action.payload.post; // 하나의 포스트의 값들을 최신 값으로 바꿔주고,
        draft.list[idx] = draft.post; // 수정된 값이 들어간 post를 list[idx] 값에 넣어준다.
        console.log(idx);
      }),
  },
  initialState
);

const actionCreators = {
  setPost,
  addPost,
  getPost,
  setPostDB,
  getOnePostDB,
  editPostDB,
  deletePostDB,
  addPostDB,
};

export { actionCreators };
