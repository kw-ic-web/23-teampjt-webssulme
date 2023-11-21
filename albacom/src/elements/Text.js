// 타이틀 및 서브타이틀 구현을 위해 사용된 Text 최소단위 컴포넌트

import React from "react";
import styled from "styled-components";

const Text = (props) => {
  const { align, bold, color, size, children, margin } = props;

  const styles = { align, bold: bold, color: color, size: size, margin };
  return <P {...styles}>{children}</P>;
};

Text.defaultProps = {
  children: null,
  bold: false,
  color: "#222831",
  size: "14px",
  margin: false,
};

const P = styled.p`
  color: ${(props) => props.color};
  font-size: ${(props) => props.size};
  font-weight: ${(props) => (props.bold ? "600" : "400")};
  ${(props) => (props.margin ? `margin: ${props.margin};` : "")}
  text-align: ${(props) => props.align};
  @media all and (max-width: 414px) {
    font-size: 1.5rem;
  }
  @media all and (max-width: 375px) {
    font-size: 1.5rem;
  }
`;

export default Text;
