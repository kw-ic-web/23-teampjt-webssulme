import produce from "immer";
import { createAction, handleActions } from "redux-actions";
import axios from "axios";
import moment from "moment";
import { config } from "../../shared/config";

// 액션
const SET_COMMENT = "SET_COMMENT"; // 댓글 불러오기
const ADD_COMMENT = "ADD_COMMENT"; // 댓글 추가
const DELETE_COMMENT = "DELETE_COMMENT"; // 댓글 삭제

// 액션 생성함수
const setComment = createAction(SET_COMMENT, (list) => ({ list }));
const addComment = createAction(ADD_COMMENT, (post) => ({ post }));
const deleteComment = createAction(DELETE_COMMENT, (list) => ({ list }));

// Initial State
const InitialState = {
  list: [],
};

// DB에 댓글 추가
const addCommentDB = (user_name, comment, post_id) => {
  return function (dispatch, getState, { history }) {
    axios({
      method: "post",
      url: `${config.api}/comment/${post_id}`,
      data: { content: comment },
    }).then((res) => {
      console.log(res);
      const new_comment_post = {
        user: res.data.comment.user,
        content: res.data.comment.content,
        createdAt: res.data.comment.createdAt,
        comment_id: moment(),
      };
      // console.log(new_comment_post);
      dispatch(addComment(new_comment_post));
    });
  };
};

// DB 댓글정보 삭제
// 현재 로그인유저 정보와 댓글 작성자 정보 비교 후 같으면 삭제(서버단에서 토큰값 이용해서 비교해주기로 함)
const deleteCommentDB = (comment_id) => {
  return function (dispatch, getState, { history }) {
    axios({
      method: "delete",
      url: `${config.api}/comment/${comment_id}`,
      data: {
        _id: comment_id,
      },
    })
      .then((res) => {
        // console.log(res);
        dispatch(deleteComment(comment_id));
      })
      .catch((err) => {
        console.log("댓글삭제 에러", err);
      });
  };
};

// 댓글 리스트 가져오기
// 포스트 정보 안에 댓글리스트가 같이 들어있기때문에 post_id 값을 이용해서 댓글리스트 찾고 가져와야함
const getCommentDB = (post_id) => {
  return function (dispatch, getState, { history }) {
    axios({
      method: "get",
      url: `${config.api}/comment/${post_id}`,
    })
      .then((docs) => {
        const comment_list = docs.data.comments;
        // console.log(comment_list);
        dispatch(setComment(comment_list));
      })
      .catch((err) => {
        console.log("댓글 가져오기 에러", err);
      });
  };
};

// 리듀서
export default handleActions(
  {
    [SET_COMMENT]: (state, action) =>
      produce(state, (draft) => {
        console.log(action.payload);
        draft.list = action.payload.list;
      }),

    [ADD_COMMENT]: (state, action) =>
      produce(state, (draft) => {
        console.log(action.payload.post);
        const new_comment = action.payload.post;
        //가장 앞에 새로운 댓글 추가하기
        draft.list.unshift(new_comment);
      }),

      [DELETE_COMMENT]: (state, action) =>
      produce(state, (draft) => {
        // 액션으로 넘어온 삭제될 댓글을 제외하고 filter 하여 댓글리스트 업데이트
        let new_comment_list = draft.list.filter((c) => {
          if (c._id !== action.payload.list) {
            return true;
          }
          return false;
        });
        draft.list = new_comment_list;
      }),
  },
  InitialState
);

const actionCreators = {
  setComment,
  addComment,
  deleteComment,
  deleteCommentDB,
  getCommentDB,
  addCommentDB,
};

export { actionCreators };
